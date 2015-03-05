import java.io.FileWriter;
import java.util.ArrayList;

import weka.classifiers.Evaluation;
import weka.classifiers.evaluation.Prediction;
import weka.classifiers.meta.Bagging;
import weka.classifiers.trees.REPTree;
import weka.clusterers.SimpleKMeans;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Add;
import weka.filters.unsupervised.instance.RemoveFrequentValues;
import au.com.bytecode.opencsv.CSVWriter;


public class Cluster_33_67_Bagging_REPTree {
	
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
		
		//Remove fraud class instances
		RemoveFrequentValues remove=new RemoveFrequentValues();
		remove.setInputFormat(train);
		remove.setAttributeIndex("last");
		remove.setNumValues(1);
		Instances train_ok=Filter.useFilter(train, remove);
		int cid4=train_ok.numAttributes()-1;
		train_ok.setClassIndex(cid4);
		
		//Remove ok class instances
		RemoveFrequentValues remove1=new RemoveFrequentValues();
		remove1.setInputFormat(train);
		remove1.setAttributeIndex("last");
		remove1.setNumValues(1);
		remove1.setUseLeastValues(true);
		Instances train_fraud=Filter.useFilter(train, remove1);
		int cid5=train_fraud.numAttributes()-1;
		train_fraud.setClassIndex(cid5);

		//remove class attribute for clustering
		 weka.filters.unsupervised.attribute.Remove filter = new weka.filters.unsupervised.attribute.Remove();
		 filter.setAttributeIndices("" + (train_ok.classIndex() + 1));
		 filter.setInputFormat(train_ok);
		 Instances dataClusterer = Filter.useFilter(train_ok, filter);
		
		//cluster using K-means
		SimpleKMeans cluster=new SimpleKMeans();
		cluster.setNumClusters(146);
		cluster.buildClusterer(dataClusterer);
		train_ok=cluster.getClusterCentroids();
		
		
		
		
		//Add deleted class attribute
		Add add_attribute=new Add();
		add_attribute.setAttributeName("status");
		add_attribute.setAttributeIndex("last");
		add_attribute.setNominalLabels("0,1");
		//SelectedTag value=
		//add_attribute.setAttributeType(value);
		add_attribute.setInputFormat(train_ok);
		train_ok=Filter.useFilter(train_ok, add_attribute);
		for (int i = 0; i < train_ok.numInstances(); i++) {
		 train_ok.instance(i).setValue(train_ok.numAttributes() - 1, "0");
	      }
		int cid7=train_ok.numAttributes()-1;
		train_ok.setClassIndex(cid7);
		
		//System.out.println(train_fraud.toSummaryString());
		//System.out.println(train_ok.toSummaryString());
		System.out.println(train_ok.numInstances());
		System.out.println(train_fraud.numInstances());
		
		//combine train_ok and train_fraud
		for(int i=0;i<train_fraud.numInstances();i++)
			train_ok.add(train_fraud.instance(i));
		train=train_ok;
		int cid6=train.numAttributes()-1;
		train.setClassIndex(cid6);
		
		
		//Bagging REPTree
		REPTree jtree=new REPTree();
		
		Bagging tree = new Bagging();
		tree.setClassifier(jtree);
		tree.buildClassifier(train);
        
       
		
	
		
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
