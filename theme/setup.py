from setuptools import setup

setup(
    name='theme',
    version='0.0.0',
    install_requires=['pynvim'],
    include_package_data=True,
    zip_safe=True,
    scripts=['bin/theme'],
)
