using FloatsForAI, Test

@testset "FloatsForAI" begin

@testset "Construction" begin
    sf = SignedFormat(8, 4, Finite)
    uf = UnsignedFormat(8, 4, Finite)
    @test sf.K == 8
    @test sf.P == 4
    @test sf.δ == false
    @test uf.K == 8
    @test uf.P == 4

    uf_e = UnsignedFormat(8, 4, Extended)
    @test is_extended(uf_e)

    @test Finite == Domain(true, false)
    @test Extended == Domain(false, true)
end

@testset "Constructor validation" begin
    @test_throws ErrorException SignedFormat(8, 0, Finite)
    @test_throws ErrorException UnsignedFormat(8, 0, Finite)
    @test_throws ErrorException SignedFormat(3, 5, Finite)
end

@testset "Type dispatch" begin
    sf = SignedFormat(8, 4, Finite)
    uf = UnsignedFormat(8, 4, Finite)

    @test sf isa Format
    @test uf isa Format
    @test sf isa SignedFormat
    @test uf isa UnsignedFormat
    @test !(sf isa UnsignedFormat)
    @test !(uf isa SignedFormat)
    @test SignedFormat <: Format
    @test UnsignedFormat <: Format
end

@testset "Signedness" begin
    sf = SignedFormat(8, 4, Finite)
    uf = UnsignedFormat(8, 4, Finite)

    @test is_signed(sf) == true
    @test is_unsigned(sf) == false
    @test is_signed(uf) == false
    @test is_unsigned(uf) == true

    @test SignBitsOf(sf) == 1
    @test SignBitsOf(uf) == 0
    @test SignMultiplicityOf(sf) == 2
    @test SignMultiplicityOf(uf) == 1
end

@testset "Domain" begin
    ff = SignedFormat(8, 4, Finite)
    fe = SignedFormat(8, 4, Extended)

    @test is_finite(ff) == true
    @test is_extended(ff) == false
    @test is_finite(fe) == false
    @test is_extended(fe) == true

    @test is_finite(Finite)
    @test is_extended(Extended)
    @test_throws ErrorException Domain(finite=true, extended=true)
    @test_throws ErrorException Domain()
end

@testset "Display" begin
    @test string(SignedFormat(8, 4, Finite))    == "Binary8p4sf"
    @test string(UnsignedFormat(8, 4, Finite))  == "Binary8p4uf"
    @test string(SignedFormat(8, 4, Extended))   == "Binary8p4se"
    @test string(UnsignedFormat(8, 4, Extended)) == "Binary8p4ue"
end

@testset "Accessors" begin
    sf = SignedFormat(8, 4, Finite)
    uf = UnsignedFormat(8, 4, Finite)

    @test BitwidthOf(sf) == 8
    @test PrecisionOf(sf) == 4
    @test TrailingBitsOf(sf) == 3

    @test ExponentFieldBitsOf(sf) == 4
    @test ExponentFieldBitsOf(uf) == 5

    @test ExponentBiasOf(sf) == 15
    @test ExponentBiasOf(uf) == 16

    @test ExponentMinOf(sf) == -14
    @test ExponentMinOf(uf) == -15
end

@testset "ExponentMaxOf" begin
    @test ExponentMaxOf(SignedFormat(8, 4, Finite)) == 7
    @test ExponentMaxOf(UnsignedFormat(8, 4, Finite)) == 15

    @test ExponentMaxOf(SignedFormat(8, 3, Finite)) == 15
    @test ExponentMaxOf(UnsignedFormat(8, 3, Finite)) == 31

    sf2 = SignedFormat(8, 2, Finite)
    uf2 = UnsignedFormat(8, 2, Finite)
    @test ExponentMaxOf(sf2) == 30
    @test ExponentMaxOf(uf2) == 62

    sf1 = SignedFormat(8, 1, Finite)
    uf1 = UnsignedFormat(8, 1, Finite)
    @test ExponentMaxOf(sf1) == 62
    @test ExponentMaxOf(uf1) == 126
end

@testset "Counts: values and infinities" begin
    sf = SignedFormat(4, 2, Finite)
    uf = UnsignedFormat(4, 2, Finite)
    se = SignedFormat(4, 2, Extended)
    ue = UnsignedFormat(4, 2, Extended)

    @test nValuesOf(sf) == 16
    @test nValuesOf(uf) == 16
    @test nNaNsOf(sf) == 1
    @test nZerosOf(sf) == 1

    @test nInfsOf(sf) == 0
    @test nInfsOf(uf) == 0
    @test nInfsOf(se) == 2
    @test nInfsOf(ue) == 1

    @test nNumericValuesOf(sf) == 15
    @test nNonFinitesOf(se) == 3
    @test nNonFinitesOf(ue) == 2
end

@testset "Counts: finites" begin
    sf = SignedFormat(4, 2, Finite)
    uf = UnsignedFormat(4, 2, Finite)

    @test nNegativeFinitesOf(uf) == 0
    @test nNegativeFinitesOf(sf) == nPositiveFinitesOf(sf)
    @test nNonnegativeFinitesOf(sf) == nPositiveFinitesOf(sf) + 1
    @test nFinitesOf(sf) == nPositiveFinitesOf(sf) + nNegativeFinitesOf(sf) + nZerosOf(sf)
    @test nFinitesOf(uf) == nPositiveFinitesOf(uf) + nZerosOf(uf)
end

@testset "Counts: subnormals" begin
    sf = SignedFormat(4, 2, Finite)
    uf = UnsignedFormat(4, 2, Finite)

    @test nNegativeSubnormalsOf(uf) == 0
    @test nNegativeSubnormalsOf(sf) == nPositiveSubnormalsOf(sf)
    @test nSubnormalsOf(sf) == 2 * nPositiveSubnormalsOf(sf)
    @test nSubnormalsOf(uf) == nPositiveSubnormalsOf(uf)
end

@testset "Counts: normals" begin
    sf = SignedFormat(4, 2, Finite)
    uf = UnsignedFormat(4, 2, Finite)

    @test nNegativeNormalsOf(uf) == 0
    @test nNegativeNormalsOf(sf) == nPositiveNormalsOf(sf)
    @test nNormalsOf(sf) == 2 * nPositiveNormalsOf(sf)
    @test nNormalsOf(uf) == nPositiveNormalsOf(uf)
end

@testset "Count consistency" begin
    for K in 2:8, P in 1:K
        for (label, fmt) in [
            ("uf", UnsignedFormat(K, P, Finite)),
            ("ue", UnsignedFormat(K, P, Extended)),
        ]
            total = nFinitesOf(fmt) + nNonFinitesOf(fmt)
            @test total == nValuesOf(fmt)

            finites = nPositiveFinitesOf(fmt) + nZerosOf(fmt)
            @test finites == nFinitesOf(fmt)

            @test nNegativeFinitesOf(fmt) == 0
            @test nNegativeSubnormalsOf(fmt) == 0
            @test nNegativeNormalsOf(fmt) == 0
        end

        P >= K && continue
        for (label, fmt) in [
            ("sf", SignedFormat(K, P, Finite)),
            ("se", SignedFormat(K, P, Extended)),
        ]
            total = nFinitesOf(fmt) + nNonFinitesOf(fmt)
            @test total == nValuesOf(fmt)

            finites = nPositiveFinitesOf(fmt) + nNegativeFinitesOf(fmt) + nZerosOf(fmt)
            @test finites == nFinitesOf(fmt)

            @test nNegativeFinitesOf(fmt) == nPositiveFinitesOf(fmt)
            @test nNegativeSubnormalsOf(fmt) == nPositiveSubnormalsOf(fmt)
            @test nNegativeNormalsOf(fmt) == nPositiveNormalsOf(fmt)
        end
    end
end

end # testset FloatsForAI
