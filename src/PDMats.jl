__precompile__()

module PDMats

    using Compat

    import Base: +, *, \, /, ==
    import Base: full, logdet, inv, diag, diagm, eigmax, eigmin, convert

    export
        # Types
        AbstractPDMat,
        PDMat,
        PDSparseMat,
        PDiagMat,
        ScalMat,

        # Functions
        dim,
        full,
        whiten,
        whiten!,
        unwhiten,
        unwhiten!,
        pdadd,
        pdadd!,
        add_scal,
        add_scal!,
        quad,
        quad!,
        invquad,
        invquad!,
        X_A_Xt,
        Xt_A_X,
        X_invA_Xt,
        Xt_invA_X,
        test_pdmat

    import Base.BLAS: nrm2, axpy!, gemv!, gemm, gemm!, trmv, trmv!, trmm, trmm!
    import Base.LAPACK: trtrs!
    import Base.LinAlg: A_ldiv_B!, A_mul_B!, A_mul_Bc!, A_rdiv_B!, A_rdiv_Bc!, Ac_ldiv_B!, Cholesky


    # The abstract base type

    @compat abstract type AbstractPDMat{T<:Real} <: AbstractMatrix{T<:Real} end

    import Base:size, getindex, chol
    size{T<:AbstractPDMat}(p::T) = size(full(p))
    getindex{T<:AbstractPDMat}(p::T, i::Int) = full(p)[i]
    getindex{T<:AbstractPDMat}(p::T, I::Vararg{Int, 2}) = getindex(full(p), I...)
    chol{T<:AbstractPDMat}(p::T) = p.chol

    # source files

    include("chol.jl")   # make Cholesky compatible with both Julia 0.3 & 0.4
    include("utils.jl")

    include("pdmat.jl")
    include("pdsparsemat.jl")
    include("pdiagmat.jl")
    include("scalmat.jl")

    include("generics.jl")
    include("addition.jl")

    include("testutils.jl")

    include("deprecates.jl")

end # module
