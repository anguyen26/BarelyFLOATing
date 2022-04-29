from setuptools import setup, find_packages
import iarm

try:
    import pypandoc
    long_description = pypandoc.convert('README.md', 'rst')
    long_description.replace('\r', '')  # PyPi doesnt like '\r\n', only '\n'
except:
    long_description = open('README.md').read()

setup(name=iarm.__title__,
      version=iarm.__version__,
      description="An interpreter for the ARM instruction set and an accompanying Jupyter kernel",
      long_description=long_description,
      url="https://github.com/DeepHorizons/iarm",
      author="Joshua Milas",
      author_email="josh.milas@gmail.com",
      license='MIT',
      packages=find_packages('.'),
      install_requires=[
            'ipykernel',
            'jupyter-client',
            'ipython',
      ],
      zip_safe=True)
