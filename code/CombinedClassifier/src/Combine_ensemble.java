import java.io.FileWriter;
import java.util.ArrayList;

import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.evaluation.Prediction;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.classifiers.meta.AdaBoostM1;
import weka.classifiers.meta.Bagging;
import weka.classifiers.meta.Stacking;
import weka.classifiers.trees.J48;
import weka.classifiers.trees.REPTree;
import weka.classifiers.trees.RandomForest;
import weka.core.Instances;
import weka.core.SelectedTag;
import weka.core.converters.ConverterUtils.DataSource;
import au.com.bytecode.opencsv.CSVWriter;
import weka.classifiers.meta.Vote;


public class Combine_ensemble {
	
	public static void main(String[] args ) throws Exception
	{
		
		Instances train=DataSource.read("/home/rajeshb/Dropbox/thesis/dataset/feature_extraction/train1(ok+obs)09feb12.arff");
		int cid1 = train.numAttributes()-1;
		train.setClassIndex(cid1);
		
		Instances validation=DataSource.read("/home/rajeshb/Dropbox/thesis/dataset/feature_extraction/validation1(ok+obs)_23feb12.arff");
		int cid2 = validation.numAttributes()-1;
		validation.setClassIndex(cid2);
		
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
		
		//VOTE: Combine multiple classifier
		Vote tree=new Vote();
		Classifier[] classifiers={btree5};
		//btree5,btree6,btree7
		
		tree.setClassifiers(classifiers);
		
		tree.addPreBuiltClassifier(btree7);
		tree.addPreBuiltClassifier(btree6);
		
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
