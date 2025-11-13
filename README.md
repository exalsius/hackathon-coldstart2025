# \[Cold Start:\] Distributed AI Hack Berlin

Repository for the [\[Cold Start:\] Distributed AI Hack Berlin 2025](https://luma.com/lsbpnuiu) organized by [exalsius](https://exalsius.ai/) and [Flower](https://flower.ai/).

This repo includes material used for the challenge **Track 01: Federated Learning for X-ray Classification**. You can find the hackathon quick start guide with all relevant instructions [here](https://logsight.notion.site/Cold-Start-Distributed-AI-Hack-Quick-Start-FAQ-2a24807968c480ce88d8c9e4035498d2?source=copy_link).

The challenge builds on the [NIH Chest X-Ray dataset](https://www.kaggle.com/datasets/nih-chest-xrays/data), which contains over 112,000 medical images from 30,000 patients. 
Participants will explore how federated learning can enable robust diagnostic models that generalize across hospitals, without sharing sensitive patient data.


## 📚 Background

In real healthcare systems, hospitals differ in their imaging devices, patient populations, and clinical practices. A model trained in one hospital often struggles in another, but because the data distributions differ.

Your task is to design a model that performs reliably across diverse hospital environments. By simulating a federated setup, where each hospital trains on local data and only model updates are shared, you’ll investigate how distributed AI can improve performance and robustness under privacy constraints.


## 🏥 Hospital Data Distribution

⚠️ All datasets (including test) are now available on HuggingFace: [exalsius/NIH-Chest-XRay-Federated](https://huggingface.co/datasets/exalsius/NIH-Chest-XRay-Federated).

Chest X-rays are among the most common and cost-effective imaging exams, yet diagnosing them remains challenging.
For this challenge, the dataset has been artificially partitioned into hospital silos to simulate a federated learning scenario with **strong non-IID characteristics**. Each patient appears in only one silo. However, age, sex, view position, and pathology distributions (AP vs PA) vary across silos.

Each patient appears in only one hospital. All splits (train/eval/test) are patient-disjoint to prevent data leakage.

### Hospital A: Portable Inpatient • 42,093 test, 5,490 eval • 18.0 GB
- **Demographics**: Elderly males (age 60+)
- **Equipment**: AP (anterior-posterior) view dominant
- **Common findings**: Fluid-related conditions (Effusion, Edema, Atelectasis)

### Hospital B: Outpatient Clinic • 21,753 train, 2,860 eval • 9.6 GB
- **Demographics**: Younger females (age 20-65)
- **Equipment**: PA (posterior-anterior) view dominant
- **Common findings**: Nodules, masses, pneumothorax

### Hospital C: Mixed with Rare Conditions • 20,594 train, 2,730 eval • 8.9 GB
- **Demographics**: Mixed age and gender
- **Equipment**: PA view preferred
- **Common findings**: Rare conditions (Hernia, Fibrosis, Emphysema)


## 🎯 Task Details

For the hackathon, we focus on **binary classification**: detecting the presence of any pathological finding.
- **Class 0**: No Finding
- **Class 1**: Any Finding present

**Pathologies (15 types)**: Atelectasis, Cardiomegaly, Effusion, Infiltration, Mass, Nodule, Pneumonia, Pneumothorax, Consolidation, Edema, Emphysema, Fibrosis, Pleural_Thickening, Hernia

**Evaluation Metric**: [AUROC](https://developers.google.com/machine-learning/crash-course/classification/roc-and-auc)


## 📁 Repository Structure

- `coldstart/`: Working starting solution with data loading, model, and federated training loop using [Flower](https://flower.dev/).
- `evaluate.py`: Evaluation script that determines the final AUROC on test sets.
- `internal/`: Internal scripts for setting up the datasets, cluster venv, and evaluating teams.


## 📝 Dataset Reference

```
@article{wang2017chestxray,
  title={ChestX-ray8: Hospital-scale Chest X-ray Database and Benchmarks},
  author={Wang, Xiaosong and Peng, Yifan and Lu, Le and Lu, Zhiyong and
          Bagheri, Mohammadhadi and Summers, Ronald M},
  journal={CVPR},
  year={2017}
}
```
