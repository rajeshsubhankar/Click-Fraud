import java.io.FileWriter;
import java.util.ArrayList;

import weka.classifiers.CostMatrix;
import weka.classifiers.Evaluation;
import weka.classifiers.evaluation.Prediction;
import weka.classifiers.meta.Bagging;
import weka.classifiers.meta.MetaCost;
import weka.classifiers.trees.J48;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.filters.Filter;
import weka.filters.supervised.instance.SMOTE;
import au.com.bytecode.opencsv.CSVWriter;


public class MetaCost_SMOTE500_Bagging_J48 {
	
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
		
		//SMOTE
		SMOTE sm=new SMOTE();
		sm.setInputFormat(train);
		sm.setNearestNeighbors(5);
		sm.setPercentage(500);
		train=Filter.useFilter(train, sm);
		
		//Bagging J48
		J48 jtree=new J48();
		
		Bagging btree = new Bagging();
		btree.setClassifier(jtree);
		//btree.buildClassifier(train);
		
		//MetaCost
		CostMatrix cm=new CostMatrix(2);
		cm.setElement(0,1,1);
		cm.setElement(1,0,1);
		cm.setElement(0,0,0);
		cm.setElement(1,1,0);
				
		MetaCost tree=new MetaCost();
		tree.setClassifier(btree);
		tree.setCostMatrix(cm);
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
