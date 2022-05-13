= Conda package

It may be needed to have a conda package.
You can create such a package from Dockerfile-conda image.
The recipe uses a tar gzipped archive from Lncmi debian repository.

```bash
sudo /opt/conda/bin/mamba install --quiet --yes 'boa'
/opt/conda/bin/boa convert meta.yaml > recipe.yaml
/opt/conda/bin/boa build .
sudo /opt/conda/bin/mamba install --quiet --yes magnettools --use-local
```

= References

[Manba](https://boa-build.readthedocs.io/en/latest/recipe_spec.html#build-section)
[Conda](https://docs.conda.io/projects/conda-build/en/latest/index.html)