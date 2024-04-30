== Introduction <introduction>

Are humans unique among animals? We seem to be the only species that speaks languages @hauserFacultyLanguageWhat2002,
but is speech somehow like other forms of acoustic communication in other animals,
such as birdsong @doupeBIRDSONGHUMANSPEECH1999?
How should we even understand the ability of some animals to learn their vocalizations
@wirthlinModularApproachVocal2019?
Questions like these are answered by studying how animals communicate with sound @hopp2012animal.
As others have argued, major advances in this research will require
cutting edge computational methods and big team science across a wide range of disciplines,
including ecology, ethology, bioacoustics, psychology, neuroscience, linguistics, and genomics
@sainburgComputationalNeuroethologyVocal2021 @stowellComputationalBioacousticsDeep2022 @wirthlinModularApproachVocal2019 @hauserFacultyLanguageWhat2002.

Research on animal acoustic communication is being revolutionized by
deep learning algorithms @sainburgComputationalNeuroethologyVocal2021 @stowellComputationalBioacousticsDeep2022 @cohen2022recent.
Deep neural network models enable answering questions that were previously impossible to address,
in part because these models automate analysis of very large datasets.
Within the study of animal acoustic communication, multiple models have been proposed
for similar tasks--we review these briefly in the next section.
These models have been implemented using a range of frameworks for neural networks,
including PyTorch (as in @cohenAutomatedAnnotationBirdsong2022 and @goffinetLowdimensionalLearnedFeature2021),
Keras and Tensorflow (as in @steinfathFastAccurateAnnotation2021 and @sainburgFindingVisualizingQuantifying2020),
and even in programming environments outside Python such as Matlab (as in @coffeyDeepSqueakDeepLearningbased2019).
Because of this, it is difficult for researchers to directly compare models,
and to understand how each performs on their own data.
Additionally, many researchers will want to experiment with their own models
to better understand the fit between tasks defined by machine learning researchers and their own question of interest.
All of these factors have created a real need for a framework that allows researchers to easily benchmark models
and apply trained models to their own data.

To address this need, we developed vak @nicholsonVak2022 (#link("https://github.com/vocalpy/vak")[https:\/\/github.com/vocalpy/vak]),
a neural network framework designed for researchers studying animal acoustic communication.
vak is already in use in at least 10-20 research groups to our knowledge,
and has already been used in several publications, including
@cohenAutomatedAnnotationBirdsong2022 @goffinetLowdimensionalLearnedFeature2021 @mcgregorSharedMechanismsAuditory2022 @provostImpactsFinetuningPhylogenetic2022.
Here we describe the design of the vak framework, and explain how vak makes it easy
for acoustic communication researchers to work with neural network models.
We have also recently published an alpha release of version 1.0 of the library,
and throughout this article we highlight enhancements made in this version
that we believe will significantly improve user experience.

=== Related work <related-work>

First, we briefly review related literature, to further motivate the need for a framework.
A very common workflow in studies of acoustic behavior is to take audio recordings of one individual animal
and segment them into a sequence of units, after which further analyses can be done,
as reviewed in @kershenbaumAcousticSequencesNonhuman2016.
Some analyses require further annotation of the units to assign them to one of some set of classes,
e.g. the unique syllables within an individual songbird's song.
An example of segmenting audio of Bengalese finch song into syllables and annotating those syllables is shown in
@fig:annotation.

#figure(
  image("../files/annotation-1b1adc5143bcb0c9c42624696eb7e262.png", width: 100%),
  caption: [Schematic of analyzing acoustic behavior as a sequence of units.
Top panel shows a spectrogram of an individual Bengalese finch's song,
consisting of units, often called syllables, separated by brief silent gaps.
Bottom panel illustrates one method for segmenting audio into syllables that are annotated:
a threshold is set on the audio amplitude to segment it into syllables
(a continuous period above the threshold), and then a human annotator labels each syllable
(e.g., with a GUI application).
Adapted from @cohenAutomatedAnnotationBirdsong2022
under #link("https://creativecommons.org/licenses/by/4.0/")[CC BY 4.0 license].],
  kind: "figure",
  supplement: [Figure],
) <fig:annotation>

Several models have been developed to detect and classify a large dataset of vocalizations from an individual animal.
These are all essentially supervised machine learning tasks. Some of these models seek to align a neural network task
with the common workflow just described @kershenbaumAcousticSequencesNonhuman2016,
where audio is segmented into a sequence of units
with any of several methods @fukuzawaComputationalMethodsGeneralised2022,
that are then labeled by a human annotator.
The first family of neural network models reduces this workflow to a
frame classification problem @graves_framewise_2005 @graves_supervised_2012.
That is, these models classify a series of _frames_,
like the columns in a spectrogram.
Sequences of units (e.g., syllables of speech or birdsong) are recovered from this series of frame classifications with post-processing.
Essentially, the post-processing finds the start and stop times of each continuous run of a single label.
Multiple neural network models have been developed for this frame classification approach,
including @cohenAutomatedAnnotationBirdsong2022 and @steinfathFastAccurateAnnotation.
A separate approach from frame classification models has been to formulate recognition of individual vocalizations
as an object detection problem. To our knowledge this has been mainly applied to mouse ultrasonic vocalizations
as in @coffeyDeepSqueakDeepLearningbased2019.

Another line of research has investigated the use of unsupervised models
to learn a latent space of vocalizations. This includes the work of @sainburgFindingVisualizingQuantifying2020
and @goffinetLowdimensionalLearnedFeature2021. These unsupervised neural network models allow for
clustering vocalizations in the learned latent space, e.g., to efficiently provide a human annotator
with an estimate of the number of classes of vocalizations
in an animal's repertoire @sainburgFindingVisualizingQuantifying2020,
and/or to measure similarity between vocalizations
of two different animals @goffinetLowdimensionalLearnedFeature2021 @zandbergBirdSongComparison2022.
It is apparent that unsupervised approaches are complementary to supervised models
that automate labor-intensive human annotation. This is another reason that a single framework
should provide access to both supervised and unsupervised models.