import java.io.FileWriter;
import java.util.ArrayList;

import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.evaluation.Prediction;
import weka.classifiers.meta.Stacking;
import weka.classifiers.trees.J48;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import au.com.bytecode.opencsv.CSVWriter;


public class Stacking_NB_J48_MLP {
	
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
		
		NaiveBayes NB=new NaiveBayes();
		J48 j48_tree=new J48();
		MultilayerPerceptron mp=new MultilayerPerceptron();
		
		Stacking tree = new Stacking();
		Classifier[] classifiers=new Classifier[2];
		classifiers[0]=j48_tree;
		classifiers[1]=mp;
		tree.setClassifiers(classifiers);
		tree.setMetaClassifier(NB);
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
