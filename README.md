### Introduction and Motivation

######  Why are we doing this project? Can you clearly present the motivation and what you did/tried to do to the class?
The problem we tried to solve was to determine whether or not a user recognized a presented image after seeing a random sequence of marker images. Why is this important? Initially we set out to classify lies vs truths, however, we found it difficult to directly measure brain waves when subjects were talking. We modified our design and came to the conclusion that classifying whether a user was familiar with an image or not was a practical alternative to a lie detector. How is classifying image familiarity an alternative to a lie detector? We believed a productionalized version of our classifier has the potential to aid courts of law in pinpointing criminals to their respective crime scenes. Our goal was to determine whether re-viewing seen images would elicit some form of response in a person’s memory and to extend the practical application of BCIs to mainstream use.

### Related work

From our class readings, we found the ‘Using single-trial EEG to predict and analyze subsequent memory’ paper to be the most helpful. This study tested the familiarity of a memorized set of 40 photos, either cars or birds and how accurately one could classify whether the subjects remembered or forgot the photos. The labelling of ‘remembered vs. forgotten’ was self reported on a scale with 5 options where the two were for varying degrees ‘unfamiliar’ and the rest had varying degrees of familiarity. Each of the 40 pictures were shown for 2 seconds with about a second inbetween to introduce the dataset. After 10 minutes, the photo
s shown every 1.5 seconds with the subjects self rating familiarity instantly. The raw EEG data coming in from 73 electrode was later filtered to contain theta, alpha, low beta, high beta, and low gamma, a similar breakdown to what the Neurosky headset recorded for our project. This project motivated us to pivot towards recognition prediction based project rather than focusing on lie detection. Our project was designed differently yet held a similar goal. This experiment  also resulted in showing statistically significant results in the alpha frequency range(7-12Hz), suggesting a possible hypothesis for what would play a significant role in classifying recognition. It is also important to note that pre-stimulus was found to oscillate

Another paper, Wavelet analysis for EEG feature extraction in deception detection, helped us in that it studied if there was a detectable difference between true and deception from the give EEG recording. They studied this by setting up a poker style setting where it was acceptable to lie, where 5 right-handed subjects were asked if a specific card was present. The subjects were financially compensated if the were successful in concealing the truth. In this study they recorded the prefrontal area from four different points, receiving a sample rate of 500Hz, very similar to the sample rate of our data. They looked at 3 different frequency ranges, associated with beta, alpha, and theta frequencies. The results found there was statistically significant features in the beta frequency range across all four of the recorded channels. This paper aided us in developing the hypothesis since the results showed that beta wave plays a role in deception as well as possible recognition of previously seen stimuli. It also gave us the motivation to see if recognition was causing these results or the creation of the lie.

### Methods

##### Data Collection
Collected data from 3 separate subjects, through the use of an experiment piloted through matlab, in association with the Neurosky system. Subjects were first primed with 20 emotionally or visually salient images, for two seconds each, in a random order. They were asked to minimize movement and just watch the screen as to mitigate any potential artifacts. Then, subjects were fitted with the Neurosky, and readings were taken while they were presented with 40 more images, 20 from the original set and 20 which were new to the subjects, again in a random order. Matlab then output a csv file with information regarding whether or not the image was a “target” (familiar) or nontarget image, as well as a corresponding timestamp associated with the beginning of showing the image, such that Neurosky and Matlab data could be synced appropriately. [Quick demonstration of Matlab experiment?]
Combining datasets
The Matlab and Neurosky data were saved as .csv files and were preprocessed using Pandas in Jupyter Notebook. Combining the datasets had its challenges. The matlab time stamps were roughly every 2 seconds while the Neurosky dataset had timestamps every 2 milliseconds. Instead of epoching for each image to create 40 datapoints, we set up the Neurosky data to be labelled while it was in the timeframe of each picture. This resulted in about 1000 consecutive datapoints to receive the same label, of either 0 or 1 for familiar or novel photos. This set a precedent for familiar and novel datapoints and we classified the data on these instances.

##### Data Preprocessing and Classification
Before classifying our data, we removed outliers which we defined to be any data point in which any feature was more than 3 standard deviations away from its respective mean.
We also made sure our dataset was balanced, meaning roughly a 50:50 ratio of true and false labels.

To classify our results, we used a Random Forest Classifier. We split the dataset into 80:20 training testing. and used a grid search with 5-fold cross validation to determine the best hyperparameters for the model. Our grid search set the hyperparameters of our classifier at 200 decision trees each with a maximum depth of 3.
(https://www.pnas.org/content/94/26/14965)

##### Strengths and limitations of a Random Forest Classifier:
Random forest is an ensemble learning method, meaning it takes a group of weak, decision tree learners, and calculates votes from each weak learner. By doing so, random forests overcome the overfitting problem that plague individual decision trees. Random Forest Classifiers are also able to give us feature importance which allowed us to visualize how important each recorded signal was to the overall classification. There are drawbacks, however, to using a random forest classifier. Because it is building an entire forest of decision trees, training and making predictions takes time. Also, the model is relatively difficult to interpret compared to a simple decision tree.
(https://www.datacamp.com/community/tutorials/random-forests-classifier-python)


### Results
###### So what did we discover?
The most important signal was the high beta wave. It’s not surprising since beta waves dominate conscious activity. Surprisingly enough, however, the least important feature in determining image recognition, according to our data, was memory. This may have been a result of our data collection method.

Before setting the optimal hyperparameters our model had a mean accuracy of 67%. After setting the optimal hyperparameters our model had a mean accuracy of 80%. The average precision was around 77% before hyperparameter tuning and 87% after.

###### What did not work:
When we first visualized the features, we were surprised to see that the distributions the brain signals varied only slightly between recognition and non-recognition. We had assumed that there would be a distinctly observable difference between brain waves, particularly the beta waves.
Since beta waves were ranked as the most important brain wave for determining image recognition, we tried to classify recognition based solely on beta waves. This did not as planned. The resulting accuracy, 54%, was little better than random chance. This implied that beta waves alone are not enough to determine recognition. We kept trying to train our classifier on subsets of the features but ultimately found that all features which were deemed important by the classifier were needed to achieve the 80% mean accuracy.

###### Limitations of our algorithm and approach:
One huge limitation we want to knowledge is the fact that the neurosky records from a single electrode. We know that information in the brain is encoded across a multitude of neurons therefore recording from a single point does not provide enough detail.

### Discussion

###### What we could have done better:
The first thing that comes to mind is the amount of data we collected. With the time constraint on this project, we were only able to get a small group of 3 test subjects. It would have been beneficial to collect more data from different people. Secondly, our test only consisted of showing users images and immediately afterwards we would test their recognition of the images. We should have also repeated the test for each subject after a period of time, a day or two after the initial test. By retesting the subjects, we would be able to observe if the beta waves were actually responsible for recognition of seen images.

###### Improvements and extensions
Going back to our motivation for this project: to determine if a person recognizes an image they’ve seen before. We know that memory is emotional and that we tend to remember events better when we have some emotional connection to them. A possible improvement upon our project would be to compare a group of emotional subjects to a more non-emotional group. This could potentially be done by selecting participants based on survey results.

A second possible improvement, which we mentioned earlier, is to re-record subjects after a certain duration to see if the same brain waves are still the most informative features for classifying image recognition.

###### How hard was what you did/tried to do?

###### What did you learn?
Our proof-of-concept showed us that its very possible to detect image recognition in brain signals. We were able to observe which brain waves contributed most to the classification of recognition versus non-recognition.
