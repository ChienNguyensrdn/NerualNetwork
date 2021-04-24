from sklearn.neural_network import MLPClassifier
import pandas as pd
import numpy as np
datasets = pd.read_csv('Data/data1.csv')
X1=datasets.iloc[:, 
        [0,1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20,
        21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,37,38,39,40,
        41,42,43,44,45,46,47,48,49,50,51,52,53
        ]
        ].values
# datasets = pd.read_csv('Data/data2.csv')
Y1 = datasets.iloc[:, 9].values

# X2=datasets.iloc[:, 
#         [0,1,2,3,4,5,6,7,8,11,12,13,14,15,16,17,18,19,20,
#         21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,37,38,39,40,
#         41,42,43,44,45,46,47,48,49,50,51,52,53
#         ]
#         ].values
# Y2 = datasets.iloc[:, 9].values

# datasets = pd.read_csv('Data/data3.csv')
# X3=datasets.iloc[:, 
#         [0,1,2,3,4,5,6,7,8,11,12,13,14,15,16,17,18,19,20,
#         21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,37,38,39,40,
#         41,42,43,44,45,46,47,48,49,50,51,52,53
#         ]
#         ].values
   
# Y3 = datasets.iloc[:, 9].values
X= X1
Y= Y1

datasets = pd.read_csv('DataValidate/data4.csv')
X_Test=datasets.iloc[:, 
        [0,1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20,
        21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,37,38,39,40,
        41,42,43,44,45,46,47,48,49,50,51,52,53
        ]
        ].values
Y_Test = datasets.iloc[:, 9].values

# for rowIdx in range(127756):
#     for colIdx in range(53):
#         if str(X[rowIdx][colIdx])=='nan':
#             X[rowIdx][colIdx]=-1

# from sklearn.model_selection import train_test_split
# X_Train, X_Test, Y_Train, Y_Test = train_test_split(X, Y, test_size = 0.25, random_state = 0)

clf = MLPClassifier( alpha=1e-5, hidden_layer_sizes=(2,10), random_state=1,activation='relu', solver='adam', max_iter=500)
clf.fit(X1, Y1)
clf.predict(X_Test)

print(clf.score(X_Test, Y_Test))