let s:packages = ''

if !empty($VIRTUAL_ENV)
    let s:packages = glob('$VIRTUAL_ENV/lib/python*/site-packages')
elseif !empty($CONDA_PREFIX)
    let s:packages = glob('$CONDA_PREFIX/lib/python*/site-packages')
endif
