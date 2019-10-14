Tests the docker image by running code generation on a sample proto file, and
comparing all output files generated.

If you have changed the _expected_ output of the code generation, replace the
`./expect` directory here with the build directory generated when running tests.
Please manually verify the changes in git diff are what you expect!

The sample file bundled here is a default Google example file. It makes for a
good test file since it imports a standard google protobuf extension, so if
imports are broken in an environment it will fail.
