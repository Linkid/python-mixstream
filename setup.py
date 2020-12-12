#!/usr/bin/env python

from skbuild import setup


try:
    import pypandoc
    long_description = pypandoc.convert('README.md', 'rst')
except ImportError:
    long_description = open('README.md').read()


# setup
setup(
    name='mixstream',
    version='1.0',
    description='MixStream is a C-extension to combine SoundTouch and SDL_mixer',
    long_description=long_description,
    long_description_content_type='text/markdown',
    author='FoFiX team',
    author_email='fofix@perdu.fr',
    url='https://github.com/fofix/python-mixstream',
    packages=['mixstream'],
    package_data={'mixstream': ['*.dll']},
    zip_safe=False,
    classifiers=[
        'Intended Audience :: Developers',
        'License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Topic :: Multimedia',
        'Topic :: Multimedia :: Sound/Audio',
        'Topic :: Software Development :: Libraries',
    ],
    keywords='music vorbis sdl soundtouch',
    setup_requires=['cmake', 'pytest-runner'],
    test_suite="tests",
    #tests_require=["pytest"],
)
