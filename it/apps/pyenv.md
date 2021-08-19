# pyenv

https://github.com/pyenv/pyenv


## hackaround to case of only using .bashrc without .bash_profile

Initiating `pyenv` has been moved from `.bashrc` file
to `.bash_profile` (`.profile`),
because `.bashrc` invoked for every shell
(few times for one session for nested shell).
See details in issue [#97](https://github.com/pyenv/pyenv-installer/issues/97).

But in my case it resulted in an error with using `SSH Upload` feature of iOS app [Working Copy](https://workingcopyapp.com/), because it doesn't use .`.bash_profile` (`.profile`) at all.

That's why I duplicated initiating `PATH` for `pyenv` in `.bashrc`, but also added control of double invoking from [a comment of issue #97](https://github.com/pyenv/pyenv-installer/issues/97#issuecomment-653685452):

```
# .bashrc content before initianig pyenv

export PYENV_ROOT="$HOME/.pyenv"
case ":${PATH}:" in
        *:"${PYENV_ROOT}/bin":*)
                ;;
        *)
                # Prepending path in case a system-installed rustc must be overwritten
                export PATH="${PYENV_ROOT}/bin:${PATH}"
                ;;
esac

# initiating pyenv
eval "$(pyenv init --path)"
```