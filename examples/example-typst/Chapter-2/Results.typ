== Results <results>

In this section we present proof-of-concept results demonstrating the utility of our framework.
The project that produced these results can be found at: #link("https://github.com/vocalpy/scipy-proceedings-2023-vak")[https:\/\/github.com/vocalpy/scipy-proceedings-2023-vak]

=== Ablation experiment <ablation-experiment>

We first show how vak allows researchers to
experiment with a model not built into the library.
For this purpose, we carry out an "ablation experiment"
as the term is used in the artificial neural network literature,
where an operation is removed from a neural network function
to show that operation plays an important role
in the model's performance.
Using a script, we define a version of the TweetyNet model in
@cohenAutomatedAnnotationBirdsong2022 without the recurrent
Long Short Term Memory (LSTM) layer (thus "ablating" it).
This model without the LSTM makes a prediction for each frame
using the output of the convolutional layers,
instead of using the hidden state of the recurrent layer
at each time step.
If the hidden state contains features that are useful
for predicting across time steps,
we would expect that "ablating" (removing) it would impair performance.
To show that removing the LSTM layer impairs performance,
we compare with the full TweetyNet model (now built into vak).
For all experiments, we prepared a single dataset
and then trained both models on that same dataset.
We specifically ran learning curves as described above,
but here we consider only the performance using 10 minutes of data for training,
because as we previously reported @cohenAutomatedAnnotationBirdsong2022
this was the minimum amount of training data required
to achieve the lowest error rates.
As shown in the top row of Figure @fig:ablation-experiment,
ablating the recurrent layer increased the frame error rate
(left column, right group of bars), and this produced
an inflated syllable error rate (right column, right group of bars).

#figure(
  image("../files/ablation-experiment-9560f0c10c7b12654df0f99807c4f9f9.png", width: 100%),
  caption: [Ablation experiment carried out by declaring a model in a script using the vak framework.
Bar plots show frame error (left column) and syllable error rate (right column),
without post-processing clean-up (blue bars) and with (orange bars).
Within each axes, the grouped bars on the left indicate results from the TweetyNet
model built into the vak library, and the grouped bars on the right indicate results from
a model declared in a script where the recurrent LSTM layer has been removed ("ablated")
from the TweetyNet architecture.
In the top row, values are the average across models trained on data from four different
Bengalese finches, with five training replicates per bird (see text for detail).
In the bottom row, single models were trained to classify syllables
from all four birds.],
  kind: "figure",
  supplement: [Figure],
) <fig:ablation-experiment>

This first result is the average across models trained on datasets
prepared from individual birds in the Bengalese finch song repository dataset @nicholson_bengalese_2017,
as we did previously in @cohenAutomatedAnnotationBirdsong2022.
(There are four birds, and five training replicates per bird,
where each replicate is trained on different subsets from a larger pool of training data.)
Other studies using the same benchmark data repository
have trained models on datasets prepared from all four birds
@steinfathFastAccurateAnnotation2021 (so that the model predicts 37 classes,
the syllables from all four birds, instead of 5-10 per bird).
We provide this result for the TweetyNet model with and without LSTM
in the bottom row of Figure @fig:ablation-experiment.
It can be seen that asking the models to predict a greater number of classes
further magnified the difference between them (as would be expected).
TweetyNet without the LSTM layer
has a syllable error rate greater than 230%.
(Because the syllable error rate is an edit distance,
it can be greater than 1.0. It is typically
written as a percentage for readability of smaller values.)

=== Comparison of TweetyNet and ED-TCN <comparison-of-tweetynet-and-ed-tcn>

We next show how vak allows researchers to compare models.
For this we compare the TweetyNet model in @cohenAutomatedAnnotationBirdsong2022
with the ED-TCN model of @lea2017temporal.
As for the ablation experiment,
we ran full learning curves,
but here just focus on the performance of models trained on 10 minutes of data.
Likewise, the grouped box plots are as in Figure @fig:ablation-experiment,
with performance of TweetyNet again on the left and in this case the ED-TCN model
on the right.
Here we only show performance of models trained on data from all four birds
(the same dataset we prepared for the ablation experiment above).
We observed that on this dataset the ED-TCN had a higher frame error and syllable error rate,
as shown in Figure @fig:tweetynet-v-edtcn.
However, there was no clear difference when training models on individual birds
(results not shown because of limited space).
Our goal here is not to make any strong claim about either model,
but simply to show that our framework makes it possible to more easily compare
two models on the exact same dataset.

#figure(
  image("../files/TweetyNet-v-EDTCN-60631050bd2d5abf681ce49ba8d23b67.png", width: 100%),
  caption: [Comparison of TweetyNet model @cohenAutomatedAnnotationBirdsong2022
with ED-TCN model.
Plots are as in @fig:ablation-experiment.
Each axes shows results for one individual bird from the
Bengalese finch song repository dataset @nicholson_bengalese_2017.
Bar plots show frame error (left column) and syllable error rate (right column),
without post-processing clean-up (blue bars) and with (orange bars).],
  kind: "figure",
  supplement: [Figure],
) <fig:tweetynet-v-edtcn>

== Applying Parametric UMAP to Bengalese finch syllables with a convolutional encoder <applying-parametric-umap-to-bengalese-finch-syllables-with-a-convolutional-encoder>

Finally we provide a result demonstrating that a researcher can apply multiple families of models
to their data with our framework.
As stated above, the vak framework includes an implementation of a Parametric UMAP family,
and one model in this family, a simple encoder network with convolutional layers on the front end.
To demonstrate this model, we train it on the song of an individual bird from
the Bengalese finch song repository.
We use a training set with a duration of 40 seconds total, containing clips of
all syllable classes from the bird's song, taken from songs that were drawn at random
from a larger data pool by the vak dataset preparation function.
We then embed a separate test set.
It can be seen in Figure @fig:parametric-umap that points that are close to each other
are almost always the same color, indicating that syllables that were given the same label
by a human annotator are also nearer to each other after mapping to 2-D space
with the trained parametric UMAP model.

#figure(
  image("../files/parametric-umap-e87627c6cc9ccd35e1a5427cb34667a4.png", width: 100%),
  caption: [Scatter plot showing syllables from the song of one Bengalese finch,
embeeded in a 2-D space using a convolutional encoder
trained using the Parametric UMAP algorithm.
Each marker is a point produced from a spectrograms
of a single syllable rendition, mapped down to the 2-D space,
from 40 seconds of training data.
Colors indicate the label applied to each syllable
by an expert human when annotating the spectrograms
with a GUI.],
  kind: "figure",
  supplement: [Figure],
) <fig:parametric-umap>