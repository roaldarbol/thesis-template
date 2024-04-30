== Discussion <discussion>

Researchers studying acoustic behavior need to benchmark multiple
neural network models on their data,
evaluate training performance for different training set sizes,
and use trained models to make predictions on newly acquired data.
Here we presented vak, a neural network framework developed to meet these needs.
In the Methods we described its design and development.
Then in the Results we provide proof-of-concept results demonstrating
how researchers can easily use our framework.

Finally, we summarize the roadmap for further development of version 1.0 of vak.
In the spirit of taking an open approach,
we are tracking issues related to this roadmap on GitHub:
#link("https://github.com/vocalpy/vak/issues/614")[https:\/\/github.com/vocalpy/vak/issues/614].
A key goal will be to add benchmark datasets,
generated by running the vak prep command,
that a user can download and use
to benchmark models with publicly shared configuration files.
Another key goal will be to add models that are pre-trained on these benchmark datasets.
Additionally we plan to refactor the prep module
to make use of the vocalpy package @nicholson_vocalpyvocalpy_2023,
developed to make acoustic communication research code
in Python more concise and readable.
Another key step will be inclusion of additional models
like those reviewed in the Related Work.
Along with this expansion of existing functionality,
the final release of version 1.0 will include several quality-of-life
improvements, including a revised schema for the configuration file format
that better leverages the strengths of TOML,
and dataclasses that represent outputs of vak,
such as dataset directories and results directories,
to make it easier to work with outputs programmatically.
It is our hope that these conveniences
plus the expanded models and datasets
will provide a framework that
can be developed collaboratively by the entire
research community studying acoustic communication in animals.