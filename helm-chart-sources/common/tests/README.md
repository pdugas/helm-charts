# Cribl Common Helm Chart Library Tests

In order to test the templates in the library, we have a small test chart here
that depends on it and we run tests in there. The approach comes from [here].

Before we can run the tests, we need to build the test chart's dependency.

```sh
helm dependency build helm-chart-sources/common/tests/common-test
```

Then we can run the tests in that chart.

```sh
docker run -ti --rm -v "$(pwd):/apps" helmunittest/helm-unittest helm-chart-sources/common/tests/common-test
```

[here]: https://github.com/helm-unittest/helm-unittest/pull/496