# Smalltalk Heroku Buildpack

This is a custom Heroku buildpack for Squeak Smalltalk applications that are built from [filetree](https://github.com/dalehenrich/filetree) repositories.

## Status

EXPERIMENTAL

[![Build Status](https://secure.travis-ci.org/frankshearar/smalltalk-heroku-buildpack.png?branch=master)](http://travis-ci.org/frankshearar/smalltalk-heroku-buildpack)

## Version / Dependencies

Currently this only supports Squeak 4.4.

Eventually this should support other Smalltalks, particularly Pharo.

## USAGE

Like other buildpacks you will need to specify the buildpack when creating
your Heroku application. Something like the following:

    heroku create --stack cedar --buildpack https://github.com/frankshearar/smalltalk-heroku-buildpack.git
    heroku plugins:install http://github.com/heroku/heroku-labs.git
    heroku labs:enable user_env_compile --app YOUR_APP_NAME

You will also need to specify environment variables after your app is
created. For instance,

    BUILDPACK_SQUEAK_BASE_URL
    SQUEAK_VERSION

These should be your S3 base URL for the Smalltalk bootstrap and Platform
distributions respectively.

## DIRECTORY STRUCTURE

This buildpack's `CACHE_DIR` has a particular layout:

```
CACHE_DIR
  +- vm.VERSION
  +- SqueakV41.sources
  +- Squeak-M.N-KKKK
      +- SqueakVMJ.sources
      +- SqueakM.N-KKKK.image
      +- SqueakM.N-KKKK.changes
```

where `M`, `N` 'J' and `KKKK` are all positive integers. (Usually 'J = N`.) `VERSION` is either `rNNNN` indicating a Cog VM, or a M.N.K version number, indicating an Interpreter VM.

## NOTES

Heroku is a 64 bit platform, and thus requires 64 bit applications. `apt-get` doesn't work on a dyno. Heroku dynos also have an ancient version of glibc - 2.11 - while the prebuilt VMs want 2.14 or 2.15. So we have to build our own VM, which requires us to build our own cmake (!).

Eventually, we want to produce a custom Squeak image that is tailored for operation in the Heroku environment: using an Interpreter compatible image, OSProcess preloaded, and so on. Right now we forgo that because, well, it's been really difficult to get this much working. We defer image production to the application, for now.

## ACKNOWLEDGEMENTS

The [cabal-heroku-buildpack](https://github.com/mbbx6spp/cabal-heroku-buildpack) provided extensive inspiration for this buildpack.

## LICENCE

MIT. See the LICENCE file.