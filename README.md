https://www.youtube.com/watch?v=f-h1zHOeXJg&feature=youtu.be

### Introduction and Motivation

The problem we tried to solve was to determine whether or not a user recognized a presented image after seeing a random sequence of marker images. Why is this important? Initially we set out to classify lies vs truths, however, we found it difficult to directly measure brain waves when subjects were talking. We modified our design and came to the conclusion that classifying whether a user was familiar with an image or not was a practical alternative to a lie detector. We believed a productionalized version of our classifier has the potential to aid courts of law in pinpointing criminals to their respective crime scenes. Our goal was to determine whether re-viewing seen images would elicit some form of response in a person’s memory and to extend the practical application of BCIs to mainstream use.


### Related work
From our class readings, we found the paper, ‘Using single-trial EEG to predict and analyze subsequent memory’ to be the most helpful. Ending up with 18 total subjects,
 this study tested the familiarity of a set of 40 photos,
either cars or birds and how accurately one could classify whether the subjects remembered or forgot the photos. The labels ‘remembered vs. forgotten’ were self reported on a 5-option scale where two were for varying degrees ‘unfamiliar’ and the rest had varying degrees of familiarity.

Each of the 40 pictures were shown for 2 seconds with about one second in between to introduce the dataset. After 10 minutes, the photos were shown every 1.5 seconds with the subjects self rating their familiarity instantly. The raw EEG data, coming in from 73 electrodes, was later filtered to contain theta, alpha, low beta, high beta, and low gamma waves.This filter breaks down the data similarly to what the Neurosky headset recorded for our project. This study aided in motivating us to pivot towards a recognition prediction based project rather than focusing on lie detection.
Our project was designed differently yet held a similar goal. This experiment  resulted in showing statistically significant results in the alpha frequency range(7-12Hz), suggesting a possible hypothesis for what would play a significant role in classifying recognition. It is also important to note that pre-stimulus was found to oscillate in the high beta-low gamma range of (25-35Hz).

Another paper, Wavelet analysis for EEG feature extraction in Deception Detection, also aided our project. It studied if there was a detectable difference between true and deception from the give EEG recording. They studied this by setting up a poker style setting where it was acceptable to lie. 5 right-handed subjects were given and shown 4 of 5 cards. Next they had to pick one of 3 new cards and report if the card they chose was in their hand or not. The subjects were financially compensated if the were successful in concealing the truth. In this study, they recorded the prefrontal cortex from four different points, receiving a sample rate of 500Hz, nearly matching the sample rate of our data. They looked at 3 different frequency ranges, associated with beta, alpha, and theta frequencies. The results found there was statistically significant features in the beta frequency range across all four of the recorded channels. This paper aided us in developing our hypothesis since the results showed that beta waves play a role in deception as well as possible recognition of previously seen stimuli. It also gave us the motivation to see if recognition was causing these results or the creation of the lie itself.

### Methods
##### Data Collection
We collected data from 3 separate subjects, through the use of an experiment piloted through matlab, in association with the Neurosky system. Subjects were first primed with 20 emotionally or visually salient images, for two seconds each, in a random order. They were asked to minimize movement and just watch the screen as to mitigate any potential artifacts. Then, subjects were fitted with the Neurosky, and readings were taken while they were presented with 40 more images, 20 from the original set and 20 which were new to the subjects, again in a random order. Matlab then output a csv file with information regarding whether or not the image was a “target” (or familiar) or nontarget image, as well as a corresponding timestamp associated with the beginning of showing the image, such that Neurosky and Matlab data could be synced appropriately.

##### Combining datasets
The Matlab and Neurosky data were saved as .csv files and were preprocessed using Pandas in Jupyter Notebook. Combining the datasets had its challenges. The matlab time stamps were roughly every 2.1 seconds while the Neurosky dataset had timestamps every 2 milliseconds. Instead of epoching for each image to create 40 datapoints, we set up the Neurosky data to be labelled while it was in the timeframe of each picture. This resulted in about 1000 consecutive datapoints to receive the same label, of either 1 or 0 for familiar or novel photos. This set a precedent for familiar and novel datapoints and we classified the data on these instances.

##### Data Preprocessing and Classification
Before classifying our data, we removed outliers which we defined to be any data point in which any feature was more than 3 standard deviations away from its respective mean.
We also made sure our dataset was balanced, meaning roughly a 50:50 ratio of true and false labels.
To classify our results, we used a Random Forest Classifier. We split the dataset into 80:20 training testing. and used a grid search with 5-fold cross validation to determine the best hyperparameters for the model. Our grid search set the hyperparameters of our classifier at 200 decision trees each with a maximum depth of 3.
(https://www.pnas.org/content/94/26/14965)


##### Strengths and limitations of a Random Forest Classifier:
Random forest is an ensemble learning method, meaning it takes a group of weak, decision tree learners, and calculates votes from each weak learner. By doing so, random forests overcome the overfitting problem that plague individual decision trees. Random Forest Classifiers also gives us feature importance, which allowed us to visualize how important each recorded signal was to the overall classification. There are drawbacks, however, to using a random forest classifier. Because it is building an entire forest of decision trees, training and making predictions takes time. Also, the model is relatively difficult to interpret compared to a simple decision tree.

### Results
##### What we discovered?
The most important signal was the high beta wave. It’s not surprising since beta waves dominate conscious activity. Surprisingly enough the least important feature in determining image recognition, according to our data, was theta waves. This may have been a result of our data collection method.


##### How well did it work?
Before setting the optimal hyperparameters our model had a mean accuracy of 67%. After setting the optimal hyperparameters our model had a mean accuracy of 80%. The average precision-recall was around 77% before hyperparameter tuning and 87% after.


##### What did not work:
When we first visualized the features, we were surprised to see that the distributions of the brain signals varied only slightly between recognition and non-recognition. We had assumed that there would be a distinctly observable difference between brain waves, particularly the beta waves.
Since beta waves were ranked as the most important brain wave for determining image recognition, we tried to classify recognition based solely on beta waves. This did not as planned. The resulting accuracy, 54%, was little better than random chance. This implied that beta waves alone are not enough to determine recognition. We kept trying to train our classifier on subsets of the features but ultimately found that all features which were deemed important by the classifier were needed to achieve the 80% mean accuracy.

##### Limitations of our algorithm and approach:
One huge limitation we want to knowledge is the fact that the neurosky records from a single electrode. We know that information in the brain is encoded across a multitude of neurons therefore recording from a single point does not provide enough detail.



### Discussion

##### What we could have done better:
The first thing that comes to mind is the amount of data we collected. With the time constraint on this project, we were only able to get a small group of 3 test subjects. It would have been beneficial to collect more data from different people. Second, our test only consisted of showing users images and immediately afterwards we would test their recognition of the images. We should have also repeated the test for each subject after a period of time, a day or two after the initial test. By retesting the subjects, we would be able to observe if the beta waves were actually responsible for recognition of seen images. Data collection, while it may have been the most difficult part of our project, was arguably the most important part.

##### Improvements and extensions
One important improvement for our project would be to fully integrate the matlab program with the signal acquisition from the Neurosky headset. This would have perfectly set up the datasets to match, improve the dataset significantly.
Another possible improvement, which we mentioned earlier, is to re-record subjects after a certain duration to see if the same brain waves are still the most informative features for classifying image recognition.

An important note is that we know memory is strongly based in emotion;  we tend to remember events better when we have some emotional connection to them. A second possible improvement upon our project would be to compare groups based on emotional sensitivity. This could potentially be done by selecting participants based on survey results.

##### What we learned
Our proof-of-concept showed us that its very possible to detect image recognition in brain signals. We were able to observe which brain waves contributed most to the classification of recognition versus non-recognition.


### Useful Links
- (https://www.datacamp.com/community/tutorials/random-forests-classifier-python)
- (https://brainworksneurotherapy.com/what-are-brainwave)
