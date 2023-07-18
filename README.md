# FEMH Classification
 
This code is used to classify data used in the IEEE FEMH Voice Data Challenge 2018. This is a dataset containing voice recordings from patients with three different pathologies and healthy controls. 

|Pathology|Training Set|Test Set|
|---------|------------|--------|
|Healthy|50|50|
|Neoplasm|40|50|
|Phonotrauma|60|230|
|Vocal palsy|50|70|

For this classifier we use the GoogLeNet model. 


| **Model**                                   | **Training samples** | **Sensitivity** | **Specificity** | **UAR** |
|---------------------------------------------|----------------------|-----------------|-----------------|---------|
| **ImageNet**                                | 200                  | 83.14%          | 64.00%          | 53.54%  |
|                                             | 600                  | 87.14%          | 54.00%          | 55.28%  |
|                                             | 1384                 | 79.14%          | 66.00%          | 49.75%  |
| **Places365**                               | 200                  | 88.29%          | 32.00%          | 63.46%  |
|                                             | 600                  | 80.00%          | 58.00%          | 60.23%  |
|                                             | 1384                 | 82.86%          | 52.00%          | 60.61%  |
| **Mini Speech Commands**                    | 200                  | 84.00%          | 54.00%          | 52.02%  |
|                                             | 600                  | 80.86%          | 56.00%          | 49.75%  |
|                                             | 1384                 | 73.71%          | 66.00%          | 45.84%  |
| **No Weights**                              | 200                  | 98.57%          | 8.00%           | 46.54%  |
|                                             | 600                  | 72.86%          | 56.00%          | 37.76%  |
|                                             | 1384                 | 77.14%          | 40.00%          | 39.24%  |

