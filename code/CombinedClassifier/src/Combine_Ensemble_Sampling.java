import java.io.FileWriter;
import java.util.ArrayList;

import weka.classifiers.Classifier;
import weka.classifiers.CostMatrix;
import weka.classifiers.Evaluation;
import weka.classifiers.bayes.BayesNet;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.evaluation.Prediction;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.classifiers.meta.AdaBoostM1;
import weka.classifiers.meta.Bagging;
import weka.classifiers.meta.MetaCost;
import weka.classifiers.meta.Stacking;
import weka.classifiers.meta.Vote;
import weka.classifiers.trees.J48;
import weka.classifiers.trees.REPTree;
import weka.classifiers.trees.RandomForest;
import weka.clusterers.SimpleKMeans;
import weka.core.Instances;
import weka.core.SelectedTag;
import weka.core.converters.ConverterUtils.DataSource;
import weka.filters.Filter;
import weka.filters.supervised.instance.Resample;
import weka.filters.supervised.instance.SMOTE;
import weka.filters.unsupervised.attribute.Add;
import weka.filters.unsupervised.instance.RemoveFrequentValues;
import au.com.bytecode.opencsv.CSVWriter;
import weka.classifiers.meta.RandomSubSpace;


public class Combine_Ensemble_Sampling {
	
	public static void main(String[] args ) throws Exception
	{
		
		//Instances train=DataSource.read("/home/rajeshb/Dropbox/thesis/click-fraud-data/final_120_train_w_labels.arff");
		Instances train=DataSource.read("/home/rajeshb/Dropbox/thesis/dataset/feature_extraction/train1(ok+obs)09feb12.arff");
		int cid1 = train.numAttributes()-1;
		train.setClassIndex(cid1);
		
		//Instances validation=DataSource.read("/home/rajeshb/Dropbox/thesis/click-fraud-data/final_120_validation_w_labels.arff");
		Instances validation=DataSource.read("/home/rajeshb/Dropbox/thesis/dataset/feature_extraction/validation1(ok+obs)_23feb12.arff");
		int cid2 = validation.numAttributes()-1;
		validation.setClassIndex(cid2);
		
		//Instances test=DataSource.read("/home/rajeshb/Dropbox/thesis/click-fraud-data/final_120_test_w_labels.arff");
		Instances test=DataSource.read("/home/rajeshb/Dropbox/thesis/dataset/feature_extraction/test1_08mar12 (ok+obs).arff");
		int cid3 = test.numAttributes()-1;
		test.setClassIndex(cid3);
		
		//adaboost J48
		J48 jtree1=new J48();
		
		AdaBoostM1 btree1 = new AdaBoostM1();
		btree1.setClassifier(jtree1);
		//btree1.buildClassifier(train);
		
		//adaboost REPTree
		REPTree jtree2=new REPTree();
		
		AdaBoostM1 btree2 = new AdaBoostM1();
		btree2.setClassifier(jtree2);
		//btree2.buildClassifier(train);
		
		//adaboost RF
		RandomForest jtree3=new RandomForest();
		
		AdaBoostM1 btree3 = new AdaBoostM1();
		btree3.setClassifier(jtree3);
		//btree3.buildClassifier(train);
		
		//bagging J48
		J48 jtree4=new J48();
		
		Bagging btree4 = new Bagging();
		btree4.setClassifier(jtree4);
		//btree4.buildClassifier(train);
		
		//Bagging REPTree
		REPTree jtree5=new REPTree();
		
		Bagging btree5 = new Bagging();
		btree5.setClassifier(jtree5);
		//btree5.buildClassifier(train);
		
		//Bagging RF
		RandomForest jtree6=new RandomForest();
		
		Bagging btree6 = new Bagging();
		btree6.setClassifier(jtree6);
		btree6.buildClassifier(train);
		
		//Stacking NB BJ48 BRF
		NaiveBayes NB7=new NaiveBayes();
		J48 j48_tree7=new J48();
		RandomForest RF7=new RandomForest();
		Bagging b17=new Bagging();
		b17.setClassifier(j48_tree7);
		Bagging b27=new Bagging();
		b27.setClassifier(RF7);
		
		
		Stacking btree7 = new Stacking();
		Classifier[] classifiers7=new Classifier[2];
		classifiers7[0]=b17;
		classifiers7[1]=b27;
		btree7.setClassifiers(classifiers7);
		btree7.setMetaClassifier(NB7);
		btree7.buildClassifier(train);
		
		//Stacking NB J48 MLP
		NaiveBayes NB8=new NaiveBayes();
		J48 j48_tree8=new J48();
		MultilayerPerceptron mp8=new MultilayerPerceptron();
		
		Stacking btree8 = new Stacking();
		Classifier[] classifiers8=new Classifier[2];
		classifiers8[0]=j48_tree8;
		classifiers8[1]=mp8;
		btree8.setClassifiers(classifiers8);
		btree8.setMetaClassifier(NB8);
		//btree8.buildClassifier(train);
		
		
		//Cluster 15:85 Bagging RF
		//*******************************************************************************************************************************
		//Remove fraud class instances
		Instances train9=train;
		RemoveFrequentValues remove9=new RemoveFrequentValues();
		remove9.setInputFormat(train9);
		remove9.setAttributeIndex("last");
		remove9.setNumValues(1);
		Instances train_ok9=Filter.useFilter(train9, remove9);
		int cid49=train_ok9.numAttributes()-1;
		train_ok9.setClassIndex(cid49);
		
		//Remove ok class instances
		RemoveFrequentValues remove19=new RemoveFrequentValues();
		remove19.setInputFormat(train9);
		remove19.setAttributeIndex("last");
		remove19.setNumValues(1);
		remove19.setUseLeastValues(true);
		Instances train_fraud9=Filter.useFilter(train9, remove19);
		int cid59=train_fraud9.numAttributes()-1;
		train_fraud9.setClassIndex(cid59);

		//remove class attribute for clustering
		 weka.filters.unsupervised.attribute.Remove filter9 = new weka.filters.unsupervised.attribute.Remove();
		 filter9.setAttributeIndices("" + (train_ok9.classIndex() + 1));
		 filter9.setInputFormat(train_ok9);
		 Instances dataClusterer9 = Filter.useFilter(train_ok9, filter9);
		
		//cluster using K-means
		SimpleKMeans cluster9=new SimpleKMeans();
		cluster9.setNumClusters(409);
		cluster9.buildClusterer(dataClusterer9);
		train_ok9=cluster9.getClusterCentroids();
		
		
		
		
		//Add deleted class attribute
		Add add_attribute9=new Add();
		add_attribute9.setAttributeName("status");
		add_attribute9.setAttributeIndex("last");
		add_attribute9.setNominalLabels("0,1");
		//SelectedTag value=
		//add_attribute.setAttributeType(value);
		add_attribute9.setInputFormat(train_ok9);
		train_ok9=Filter.useFilter(train_ok9, add_attribute9);
		for (int i = 0; i < train_ok9.numInstances(); i++) {
		 train_ok9.instance(i).setValue(train_ok9.numAttributes() - 1, "0");
	      }
		int cid79=train_ok9.numAttributes()-1;
		train_ok9.setClassIndex(cid79);
		
		//System.out.println(train_fraud.toSummaryString());
		//System.out.println(train_ok.toSummaryString());
		System.out.println(train_ok9.numInstances());
		System.out.println(train_fraud9.numInstances());
		
		//combine train_ok and train_fraud
		for(int i=0;i<train_fraud9.numInstances();i++)
			train_ok9.add(train_fraud9.instance(i));
		train9=train_ok9;
		int cid69=train9.numAttributes()-1;
		train9.setClassIndex(cid69);
		
		
		//Bagging RF
		RandomForest rf9=new RandomForest();
		
		Bagging btree9 = new Bagging();
		btree9.setClassifier(rf9);
		btree9.buildClassifier(train9);
		//************************************************************************************************************************************************
		
		
		//cluster 33:67 stacking NB BJ48 BRF
		//************************************************************************************************************************************************
		//Remove fraud class instances
		Instances train10=train;
		RemoveFrequentValues remove10=new RemoveFrequentValues();
		remove10.setInputFormat(train10);
		remove10.setAttributeIndex("last");
		remove10.setNumValues(1);
		Instances train_ok10=Filter.useFilter(train10, remove10);
		int cid410=train_ok10.numAttributes()-1;
		train_ok10.setClassIndex(cid410);
		
		//Remove ok class instances
		RemoveFrequentValues remove110=new RemoveFrequentValues();
		remove110.setInputFormat(train10);
		remove110.setAttributeIndex("last");
		remove110.setNumValues(1);
		remove110.setUseLeastValues(true);
		Instances train_fraud10=Filter.useFilter(train10, remove110);
		int cid510=train_fraud10.numAttributes()-1;
		train_fraud10.setClassIndex(cid510);

		//remove class attribute for clustering
		 weka.filters.unsupervised.attribute.Remove filter10 = new weka.filters.unsupervised.attribute.Remove();
		 filter10.setAttributeIndices("" + (train_ok10.classIndex() + 1));
		 filter10.setInputFormat(train_ok10);
		 Instances dataClusterer10 = Filter.useFilter(train_ok10, filter10);
		
		//cluster using K-means
		SimpleKMeans cluster10=new SimpleKMeans();
		cluster10.setNumClusters(146);
		cluster10.buildClusterer(dataClusterer10);
		train_ok10=cluster10.getClusterCentroids();
		
		
		
		
		//Add deleted class attribute
		Add add_attribute10=new Add();
		add_attribute10.setAttributeName("status");
		add_attribute10.setAttributeIndex("last");
		add_attribute10.setNominalLabels("0,1");
		//SelectedTag value=
		//add_attribute.setAttributeType(value);
		add_attribute10.setInputFormat(train_ok10);
		train_ok10=Filter.useFilter(train_ok10, add_attribute10);
		for (int i = 0; i < train_ok10.numInstances(); i++) {
		 train_ok10.instance(i).setValue(train_ok10.numAttributes() - 1, "0");
	      }
		int cid710=train_ok10.numAttributes()-1;
		train_ok10.setClassIndex(cid710);
		
		//System.out.println(train_fraud.toSummaryString());
		//System.out.println(train_ok.toSummaryString());
		System.out.println(train_ok10.numInstances());
		System.out.println(train_fraud10.numInstances());
		
		//combine train_ok and train_fraud
		for(int i=0;i<train_fraud10.numInstances();i++)
			train_ok10.add(train_fraud10.instance(i));
		train10=train_ok10;
		int cid610=train10.numAttributes()-1;
		train10.setClassIndex(cid610);
		
		
		//Stacking NB BJ48 BRF
		NaiveBayes NB10=new NaiveBayes();
		J48 j48_tree10=new J48();
		RandomForest RF10=new RandomForest();
		Bagging b110=new Bagging();
		b110.setClassifier(j48_tree10);
		Bagging b210=new Bagging();
		b210.setClassifier(RF10);
		
		
		Stacking btree10 = new Stacking();
		Classifier[] classifiers10=new Classifier[2];
		classifiers10[0]=b110;
		classifiers10[1]=b210;
		btree10.setClassifiers(classifiers10);
		btree10.setMetaClassifier(NB10);
		btree10.buildClassifier(train10);
        
		//************************************************************************************************************************************************
		
		
		//Cluster 50:50 Bagging RF
		//************************************************************************************************************************************************
		//Remove fraud class instances
		Instances train11=train;
		RemoveFrequentValues remove11=new RemoveFrequentValues();
		remove11.setInputFormat(train11);
		remove11.setAttributeIndex("last");
		remove11.setNumValues(1);
		Instances train_ok11=Filter.useFilter(train11, remove11);
		int cid411=train_ok11.numAttributes()-1;
		train_ok11.setClassIndex(cid411);
		
		//Remove ok class instances
		RemoveFrequentValues remove111=new RemoveFrequentValues();
		remove111.setInputFormat(train11);
		remove111.setAttributeIndex("last");
		remove111.setNumValues(1);
		remove111.setUseLeastValues(true);
		Instances train_fraud11=Filter.useFilter(train11, remove111);
		int cid511=train_fraud11.numAttributes()-1;
		train_fraud11.setClassIndex(cid511);

		//remove class attribute for clustering
		 weka.filters.unsupervised.attribute.Remove filter11 = new weka.filters.unsupervised.attribute.Remove();
		 filter11.setAttributeIndices("" + (train_ok11.classIndex() + 1));
		 filter11.setInputFormat(train_ok11);
		 Instances dataClusterer11 = Filter.useFilter(train_ok11, filter11);
		
		//cluster using K-means
		SimpleKMeans cluster11=new SimpleKMeans();
		cluster11.setNumClusters(72);
		cluster11.buildClusterer(dataClusterer11);
		train_ok11=cluster11.getClusterCentroids();
		
		
		
		
		//Add deleted class attribute
		Add add_attribute11=new Add();
		add_attribute11.setAttributeName("status");
		add_attribute11.setAttributeIndex("last");
		add_attribute11.setNominalLabels("0,1");
		//SelectedTag value=
		//add_attribute.setAttributeType(value);
		add_attribute11.setInputFormat(train_ok11);
		train_ok11=Filter.useFilter(train_ok11, add_attribute11);
		for (int i = 0; i < train_ok11.numInstances(); i++) {
		 train_ok11.instance(i).setValue(train_ok11.numAttributes() - 1, "0");
	      }
		int cid711=train_ok11.numAttributes()-1;
		train_ok11.setClassIndex(cid711);
		
		//System.out.println(train_fraud.toSummaryString());
		//System.out.println(train_ok.toSummaryString());
		
		//combine train_ok and train_fraud
		for(int i=0;i<train_fraud11.numInstances();i++)
			train_ok11.add(train_fraud11.instance(i));
		train11=train_ok11;
		int cid611=train11.numAttributes()-1;
		train11.setClassIndex(cid611);
		
		
		//Bagging with RF
		RandomForest rf11=new RandomForest();
		
		Bagging btree11 = new Bagging();
		btree11.setClassifier(rf11);
		btree11.buildClassifier(train11);
		//************************************************************************************************************************************************
		
		//Resampling bagging REPTree
		//************************************************************************************************************************************************
		//Resampling 17:83
		Instances train12=train;
		Resample rs12=new Resample();
		rs12.setBiasToUniformClass(0.3);
		rs12.setInputFormat(train12);
		rs12.setSampleSizePercent(100);
		train12=Filter.useFilter(train12, rs12);
		System.out.println(train12.numInstances());
		
		//Bagging REPTree
		REPTree jtree12=new REPTree();
		
		Bagging btree12 = new Bagging();
		btree12.setClassifier(jtree12);
		btree12.buildClassifier(train12);
		//************************************************************************************************************************************************
		
		//SMOTE100 Stacking NB BJ48 BRF
		//************************************************************************************************************************************************
		Instances train13=train;
		NaiveBayes NB13=new NaiveBayes();
		J48 j48_tree13=new J48();
		RandomForest RF13=new RandomForest();
		Bagging b113=new Bagging();
		b113.setClassifier(j48_tree13);
		Bagging b213=new Bagging();
		b213.setClassifier(RF13);
		
		//SMOTE
		SMOTE sm13=new SMOTE();
		sm13.setInputFormat(train13);
		sm13.setNearestNeighbors(5);
		sm13.setPercentage(100);
		train13=Filter.useFilter(train13, sm13);
		
		//Stacking NB BJ48 BRF
		Stacking btree13 = new Stacking();
		Classifier[] classifiers13=new Classifier[2];
		classifiers13[0]=b113;
		classifiers13[1]=b213;
		btree13.setClassifiers(classifiers13);
		btree13.setMetaClassifier(NB13);
		btree13.buildClassifier(train13);
		//************************************************************************************************************************************************
		
		//SMOTE 500 Bagging J48
		//************************************************************************************************************************************************
		//SMOTE
		Instances train14=train;
		SMOTE sm14=new SMOTE();
		sm14.setInputFormat(train14);
		sm14.setNearestNeighbors(5);
		sm14.setPercentage(500);
		train14=Filter.useFilter(train14, sm14);
		
		//Bagging J48
		J48 jtree14=new J48();
		
		Bagging btree14 = new Bagging();
		btree14.setClassifier(jtree14);
		btree14.buildClassifier(train14);
		//************************************************************************************************************************************************
		
		//Random Subspace J48
		//************************************************************************************************************************************************
		Instances train15=train;
		J48 jtree15=new J48();
		
		RandomSubSpace btree15=new RandomSubSpace();
		btree15.setClassifier(jtree15);
		btree15.buildClassifier(train15);
		//************************************************************************************************************************************************
		
		//Cluster 15:85 Bagging J48
		//************************************************************************************************************************************************
		//Remove fraud class instances
		Instances train16=train;
		RemoveFrequentValues remove16=new RemoveFrequentValues();
		remove16.setInputFormat(train16);
		remove16.setAttributeIndex("last");
		remove16.setNumValues(1);
		Instances train_ok16=Filter.useFilter(train16, remove16);
		int cid416=train_ok16.numAttributes()-1;
		train_ok16.setClassIndex(cid416);
		
		//Remove ok class instances
		RemoveFrequentValues remove116=new RemoveFrequentValues();
		remove116.setInputFormat(train16);
		remove116.setAttributeIndex("last");
		remove116.setNumValues(1);
		remove116.setUseLeastValues(true);
		Instances train_fraud16=Filter.useFilter(train16, remove116);
		int cid516=train_fraud16.numAttributes()-1;
		train_fraud16.setClassIndex(cid516);

		//remove class attribute for clustering
		weka.filters.unsupervised.attribute.Remove filter16 = new weka.filters.unsupervised.attribute.Remove();
		filter16.setAttributeIndices("" + (train_ok16.classIndex() + 1));
		filter16.setInputFormat(train_ok16);
		Instances dataClusterer16 = Filter.useFilter(train_ok16, filter16);
		
		//cluster using K-means
		SimpleKMeans cluster16=new SimpleKMeans();
		cluster16.setNumClusters(409);
		cluster16.buildClusterer(dataClusterer16);
		train_ok16=cluster16.getClusterCentroids();
		
		
		
		
		//Add deleted class attribute
		Add add_attribute16=new Add();
		add_attribute16.setAttributeName("status");
		add_attribute16.setAttributeIndex("last");
		add_attribute16.setNominalLabels("0,1");
		//SelectedTag value=
		//add_attribute.setAttributeType(value);
		add_attribute16.setInputFormat(train_ok16);
		train_ok16=Filter.useFilter(train_ok16, add_attribute16);
		for (int i = 0; i < train_ok16.numInstances(); i++) {
		 train_ok16.instance(i).setValue(train_ok16.numAttributes() - 1, "0");
	      }
		int cid716=train_ok16.numAttributes()-1;
		train_ok16.setClassIndex(cid716);
		
		//System.out.println(train_fraud.toSummaryString());
		//System.out.println(train_ok.toSummaryString());
		System.out.println(train_ok16.numInstances());
		System.out.println(train_fraud16.numInstances());
		
		//combine train_ok and train_fraud
		for(int i=0;i<train_fraud16.numInstances();i++)
			train_ok16.add(train_fraud16.instance(i));
		train16=train_ok16;
		int cid616=train16.numAttributes()-1;
		train16.setClassIndex(cid616);
		
		
		//Bagging J48
		J48 jtree16=new J48();
		
		Bagging btree16 = new Bagging();
		btree16.setClassifier(jtree16);
		btree16.buildClassifier(train16);
		//************************************************************************************************************************************************
		
		
		//Cluster 33:67 Bagging J48
		//************************************************************************************************************************************************
		//Remove fraud class instances
		Instances train17=train;
		RemoveFrequentValues remove17=new RemoveFrequentValues();
		remove17.setInputFormat(train17);
		remove17.setAttributeIndex("last");
		remove17.setNumValues(1);
		Instances train_ok17=Filter.useFilter(train17, remove17);
		int cid417=train_ok17.numAttributes()-1;
		train_ok17.setClassIndex(cid417);
		
		//Remove ok class instances
		RemoveFrequentValues remove117=new RemoveFrequentValues();
		remove117.setInputFormat(train17);
		remove117.setAttributeIndex("last");
		remove117.setNumValues(1);
		remove117.setUseLeastValues(true);
		Instances train_fraud17=Filter.useFilter(train17, remove117);
		int cid517=train_fraud17.numAttributes()-1;
		train_fraud17.setClassIndex(cid517);

		//remove class attribute for clustering
		 weka.filters.unsupervised.attribute.Remove filter17 = new weka.filters.unsupervised.attribute.Remove();
		 filter17.setAttributeIndices("" + (train_ok17.classIndex() + 1));
		 filter17.setInputFormat(train_ok17);
		 Instances dataClusterer17 = Filter.useFilter(train_ok17, filter17);
		
		//cluster using K-means
		SimpleKMeans cluster17=new SimpleKMeans();
		cluster17.setNumClusters(146);
		cluster17.buildClusterer(dataClusterer17);
		train_ok17=cluster17.getClusterCentroids();
		
		
		
		
		//Add deleted class attribute
		Add add_attribute17=new Add();
		add_attribute17.setAttributeName("status");
		add_attribute17.setAttributeIndex("last");
		add_attribute17.setNominalLabels("0,1");
		//SelectedTag value=
		//add_attribute.setAttributeType(value);
		add_attribute17.setInputFormat(train_ok17);
		train_ok17=Filter.useFilter(train_ok17, add_attribute17);
		for (int i = 0; i < train_ok17.numInstances(); i++) {
		 train_ok17.instance(i).setValue(train_ok17.numAttributes() - 1, "0");
	      }
		int cid717=train_ok17.numAttributes()-1;
		train_ok17.setClassIndex(cid717);
		
		//System.out.println(train_fraud.toSummaryString());
		//System.out.println(train_ok.toSummaryString());
		System.out.println(train_ok17.numInstances());
		System.out.println(train_fraud17.numInstances());
		
		//combine train_ok and train_fraud
		for(int i=0;i<train_fraud17.numInstances();i++)
			train_ok17.add(train_fraud17.instance(i));
		train17=train_ok17;
		int cid617=train17.numAttributes()-1;
		train17.setClassIndex(cid617);
		
		
		//Bagging J48
		J48 jtree17=new J48();
		
		Bagging btree17 = new Bagging();
		btree17.setClassifier(jtree17);
		btree17.buildClassifier(train17);
		//************************************************************************************************************************************************
		
		
		//RF
		//************************************************************************************************************************************************
		Instances train18=train;
		RandomForest btree18 = new RandomForest();
		btree18.setNumTrees(41); 
        btree18.buildClassifier(train18);
		//************************************************************************************************************************************************
		
        //Bayes NET
        //************************************************************************************************************************************************
		Instances train19=train;
        BayesNet btree19 = new BayesNet();
		btree19.buildClassifier(train19);
        //************************************************************************************************************************************************
        
		//MLP
		//************************************************************************************************************************************************
		Instances train20=train;
		MultilayerPerceptron btree20 = new MultilayerPerceptron();
		btree20.buildClassifier(train20);
		//************************************************************************************************************************************************
		
		//MetaCost Bagging RF
		//************************************************************************************************************************************************
		Instances train21=train;
		RandomForest rf21=new RandomForest();
		
		Bagging tree21 = new Bagging();
		tree21.setClassifier(rf21);
		//tree.buildClassifier(train);
		
		//MetaCost
		CostMatrix cm21=new CostMatrix(2);
		cm21.setElement(0,1,1);
		cm21.setElement(1,0,5);
		cm21.setElement(0,0,0);
		cm21.setElement(1,1,0);
				
		MetaCost btree21=new MetaCost();
		btree21.setClassifier(tree21);
		btree21.setCostMatrix(cm21);
		btree21.buildClassifier(train21);
		//************************************************************************************************************************************************
		
		//VOTE: Combine multiple classifier
		Vote tree=new Vote();
		Classifier[] classifiers={btree3,btree4,btree5,btree6};
		//btree5,btree6,btree7
		//btree4,btree5,btree6,btree7,btree11,btree15,btree16,btree17
		//4,5,6,7,11,16,17
		//3,4,5,6,7,11,16,17
		//3,4,5,6,7,10,11,15,16,17
		//3,4,5,6,7,10,11,15,17
		//3,4,5,6,7,10,11,15,17,18
		//3,4,5,6,7,10,11,15,17,18,20
		//3,4,5,6,7,10,11,15,17,18,19,20 --62% ap
		//1,3,4,5,6,7,10,11,15,17,18,19,20 --58% ap
		//3,4,5,6,7,9,10,11,15,17,18,19,20 --60% ap
		//3,4,5,6,7,10,11,12,15,17,18,19,20 --60% ap
		
		tree.setClassifiers(classifiers);
		
		tree.addPreBuiltClassifier(btree15);
		tree.addPreBuiltClassifier(btree19);
		tree.addPreBuiltClassifier(btree17);
		tree.addPreBuiltClassifier(btree7);
		tree.addPreBuiltClassifier(btree11);
		tree.addPreBuiltClassifier(btree10);
		tree.addPreBuiltClassifier(btree18);
		tree.addPreBuiltClassifier(btree20);
		//tree.addPreBuiltClassifier(btree9);
		//tree.addPreBuiltClassifier(btree12);
		//tree.addPreBuiltClassifier(btree15);
		//tree.addPreBuiltClassifier(btree11);
		
		//combination criteria
		tree.setCombinationRule(new SelectedTag(Vote.AVERAGE_RULE,Vote.TAGS_RULES));	
		//tree.setCombinationRule(new SelectedTag(Vote.MAJORITY_VOTING_RULE,Vote.TAGS_RULES));	
		//tree.setCombinationRule(new SelectedTag(Vote.MAX_RULE,Vote.TAGS_RULES));	
		//tree.setCombinationRule(new SelectedTag(Vote.MIN_RULE,Vote.TAGS_RULES));	
		//tree.setCombinationRule(new SelectedTag(Vote.PRODUCT_RULE,Vote.TAGS_RULES));	
		
		tree.buildClassifier(train);
		
        
       /* J48 tree = new J48();
		tree.buildClassifier(train);*/
		
	
		
		Evaluation eval = new Evaluation(train);
		eval.evaluateModel(tree,validation);
		System.out.println(eval.toSummaryString("\nResults_RF\n\n", false));
		System.out.println(eval.toClassDetailsString());
		System.out.println(eval.toMatrixString());
		
		ArrayList<Prediction> al=eval.predictions();
		ArrayList<String[]> as = new ArrayList<String[]>(al.size());
		for(int i=0;i<al.size();i++)
		{
			String[] s=new String[1];
			s[0]=al.get(i).toString();
			s[0]=s[0].substring(9,11);
			as.add(s);
		}
		ArrayList<String[]> li=new ArrayList<String[]>(al.size());
		li.addAll(as);
		//System.out.println("Contents of al: " + al);
		//System.out.println("size of al: " + al.size());
		
		String csv = "/home/rajeshb/test/output.csv";
	    CSVWriter writer = new CSVWriter(new FileWriter(csv));  
	  

	    writer.writeAll(li);  
	    writer.close();    
	}

}
