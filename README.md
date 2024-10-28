# Ensemble-Classification-Using-Multi-split-Deep-Rule-Forests
This repository focuses on model-centric machine learning development. \
It includes the implementation of a multi-split Deep Rule Forest (DRF) algorithm developed in R. The multi-split DRF enhances the traditional DRF by improving data representation learning and classification accuracy while maintaining interpretability.

## Overview
Recent advancements in Deep Neural Networks (DNNs), often referred to as black-box models, have demonstrated their potential but also their lack of interpretability, which poses challenges in critical decision-making. The goal of this work is to develop an interpretable algorithm that combines powerful predictive capabilities with efficient training.

To achieve interpretability, we leverage the Deep Rule Forest (DRF) algorithm, a tree-based method that generates complex rules, enhances predictive accuracy, and maintains transparency, resulting in purer nodes and improved performance with fewer trees. However, a significant challenge with the DRF algorithm is its extensive training time.

To address these limitations, I developed the multi-split Deep Rule Forest (DRF), which utilizes the C5.0 tree structure to learn more effective representations through a layer-wise approach.

## Experimental Results

We experimented with the multi-split Deep Rule Forest (DRF) on the Poker (Dua & Graff, 2019), Churn (Kohavi et al., 1994), and MNIST (Li Deng, 2012) datasets, all of which have categorical features as target variables.

Below, we provide an overview of the datasets and experiment details.

The Poker dataset aims to predict poker hands using 10 input features, which represent the combination of the suit and rank of five playing cards. The original dataset contains 25,010 training samples and 1,000,000 testing samples. For our experiments, we sampled 10,000 instances from the original testing set.

The Churn dataset predicts whether a customer will cease doing business with a company, consisting of 3,333 training samples and 1,667 testing samples.

The MNIST dataset seeks to classify handwritten digits represented by 28x28 pixel images, containing 10,000 training images and 5,000 testing images. We removed columns with identical values from the original 784 columns, resulting in 675 columns. The experiments were implemented in R using RStudio, where we compared our approach with other algorithms, including Multilayer Perceptron (MLP) from RSNNS (Bergmeir & Benitez, 2012), Random Forest from the RandomForest and ranger packages (Wright & Zeigler, 2015), C5.0 (Kuhn et al., 2014), XGBoost (Chen & Guestrin, 2016), and CART trees in rpart (Therneau & Foundation, n.d.).

Since the Iris dataset is relatively small, we present the interpretability of the model using this dataset. See Table 3 for details on all datasets.
Dataset overview:
| Dataset    | Train size | Test size | # of predictor | # of classes |
| -------- | ------- | ------- | ------- | ------- |
| Poker  | 25,010    | 10,000    | 10 | 10|
| Churn | 3,333     | 1667    | 19 | 2|
| Mnist    | 10,000    | 5000    |675 | 9|

Experinmental results:

![Screen Shot 2024-10-27 at 5 49 29 PM](https://github.com/user-attachments/assets/99493b3d-4759-4e1d-a8f1-ea0baff8a4da)

![Screen Shot 2024-10-27 at 5 49 43 PM](https://github.com/user-attachments/assets/c19ef572-5d43-407d-81ec-392f3b710ad2)
![Screen Shot 2024-10-27 at 5 49 53 PM](https://github.com/user-attachments/assets/54e7573a-4b07-448b-bf5a-fce8a66166a0)


## Installation Instructions
You can install the all required R packages by running `package_installaion.R` 

## Usage
How to Use: Explain how to run your project. This can include command-line usage, function calls, or examples.
Code Examples: Provide example code snippets to demonstrate usage.


## Acknowledgments
Credits: Acknowledge any resources, libraries, or individuals that helped in the development of your project.

## Contact Information
**My name**: Jasmine Hung \
**Email**: qwe102339@gmail.com\
**LinkedIn**: [Let's connect](https://www.linkedin.com/in/jasmine-hung-043149238/) 

