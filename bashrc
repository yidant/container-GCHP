# General environment config
export CC=gcc
export CXX=g++
export FC=gfortran

# OpenMP config
export OMP_NUM_THREADS=$LSB_DJOB_NUMPROC
export OMP_STACKSIZE=500m

# OpenMPI config
export OMPI_MCA_btl_vader_single_copy_mechanism=none

# OpenMPI config oversubsribe
export rmaps_base_oversubscribe=true
export PRTE_MCA_rmaps_default_mapping_policy=:oversubscribe

# GEOS-Chem environment variables
if [ -x "$(command -v nc-config)" ]; then
        export GC_BIN=$(nc-config --prefix)/bin
        export GC_INCLUDE=$(nc-config --prefix)/include
        export GC_LIB=$(nc-config --prefix)/lib
fi

if [ -x "$(command -v nf-config)" ]; then
        export GC_F_BIN=$(nf-config --prefix)/bin
        export GC_F_INCLUDE=$(nf-config --prefix)/include
        export GC_F_LIB=$(nf-config --prefix)/lib
fi

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/intel/bin:/opt/spack/bin:/opt/geos-chem/bin
if [ -x "$(command -v spack)" ]; then
        export NETCDF_HOME=$(spack location -i netcdf-c)
        export GC_BIN=$NETCDF_HOME/bin 
        export GC_INCLUDE=$NETCDF_HOME/include
        export GC_LIB=$NETCDF_HOME/lib 
        export NETCDF_FORTRAN_HOME=$(spack location -i netcdf-fortran) 
        export GC_F_BIN=$NETCDF_FORTRAN_HOME/bin 
        export GC_F_INCLUDE=$NETCDF_FORTRAN_HOME/include 
        export GC_F_LIB=$NETCDF_FORTRAN_HOME/lib
fi

export SPACK_ROOT=/opt/spack
. /opt/spack/share/spack/setup-env.sh

git config --global --add safe.directory '*'

#LSF: detect packages. 
export MODULEPATH=$MODULEPATH:/usr/share/Modules/modulefiles
export gFTL_ROOT=/opt/gFTL/GFTL-1.2
export ESMF_ROOT=/usr/local
spack load gcc@10.2.0
spack load hdf5@1.14.2
spack load netcdf-c
spack load netcdf-fortran
spack load openmpi@3.0.5
spack load esmf
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

