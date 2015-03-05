import numpy as np
import csv
from sklearn.metrics import *

data = csv.reader(open('validation_true_score.csv', 'rb'), delimiter=",", quotechar='|')
true_score, obtained_score = [], []

for row in data:
    true_score.append(int(row[0]))
    

data = csv.reader(open('validation_obtained_score.csv', 'rb'), delimiter=",", quotechar='|')

for row in data:
    obtained_score.append(int(row[0]))
print 'average precision:'
print average_precision_score(true_score, obtained_score)  

print 'confusion matrix'
print confusion_matrix(true_score,obtained_score)

print 'classification_report'
print classification_report(true_score,obtained_score)
