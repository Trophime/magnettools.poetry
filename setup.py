#!/usr/bin/env python

"""The setup script."""

from setuptools import setup, find_packages

with open('README.md') as readme_file:
    readme = readme_file.read()

requirements = [ 'numpy', 'scipy', 'matplotlib', 'mplcursors', 'tabulate', 'pandas']

setup_requirements = [ ]
test_requirements = [ ]

setup(
    author="Christophe Trophime",
    author_email='christophe.trophime@lncmi.cnrs.fr',
    python_requires='>=3.5',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Natural Language :: English',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.11',
    ],
    description="Python MagnetTools bindings",
    entry_points={
        'console_scripts': [
            'python_bmap=MagnetTools.Bmap:main',
        ],
    },
    install_requires=requirements,
    license="MIT license",
    long_description=readme,
    include_package_data=True,
    keywords='magnettools',
    name='magnettools',
    packages=find_packages(include=['magnettools', 'magnettools.*']),
    package_data={'magnettools': ['_magnetTools.so']},
    setup_requires=setup_requirements,
    test_suite='tests',
    tests_require=test_requirements,
    url='https://github.com/feelpp/magnettools',
    version='1.0.7',
    zip_safe=False,
)

