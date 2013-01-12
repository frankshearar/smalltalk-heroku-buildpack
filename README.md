# Smalltalk Heroku Buildpack

This is a custom Heroku buildpack for Squeak Smalltalk applications that are built from [filetree](https://github.com/dalehenrich/filetree) repositories.

## Status

EXPERIMENTAL

[![Build Status](https://secure.travis-ci.org/frankshearar/smalltalk-heroku-buildpack.png?branch=master)](http://travis-ci.org/frankshearar/smalltalk-heroku-buildpack)

## Version / Dependencies

Currently this only supports Squeak 4.4.

Eventually this should support other Smalltalks, particularly Pharo.

## Usage

Like other buildpacks you will need to specify the buildpack when creating
your Heroku application. Something like the following:

    heroku create --stack cedar --buildpack https://github.com/frankshearar/smalltalk-heroku-buildpack.git
    heroku plugins:install http://github.com/heroku/heroku-labs.git
    heroku labs:enable user_env_compile --app YOUR_APP_NAME

You will also need to specify environment variables after your app is
created. For instance,

    BUILDPACK_GHC_BASE_URL
    GHC_VERSION

These should be your S3 base URL for the Smalltalk bootstrap and Platform
distributions respectively.

## ACKNOWLEDGEMENTS

The [cabal-heroku-buildpack](https://github.com/mbbx6spp/cabal-heroku-buildpack) provided extensive inspiration for this buildpack.

## LICENCE

MIT. See the LICENCE file.