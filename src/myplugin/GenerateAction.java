package myplugin;

import java.awt.event.ActionEvent;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import com.nomagic.magicdraw.actions.MDAction;
import com.nomagic.magicdraw.core.Application;
import com.nomagic.uml2.ext.magicdraw.auxiliaryconstructs.mdmodels.Model;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import myplugin.analyzer.AnalyzeException;
import myplugin.analyzer.ModelAnalyzer;
import myplugin.generator.ControllerGenerator;
import myplugin.generator.RepositoryGenerator;
import myplugin.generator.ServiceGenerator;
import myplugin.generator.ServiceImplGenerator;
import myplugin.generator.EJBGenerator;
import myplugin.generator.HTMLGenerator;
import myplugin.generator.JSAppGenerator;
import myplugin.generator.JSControllerGenerator;
import myplugin.generator.JSServiceGenerator;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;

/** Action that activate code generation */
class GenerateAction extends MDAction{
	
	
	public GenerateAction(String name) {			
		super("", name, null, null);		
	}

	public void actionPerformed(ActionEvent evt) {
		
		if (Application.getInstance().getProject() == null) return;
		Model root = Application.getInstance().getProject().getModel();
		if (root == null) return;
	
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "ejb");	
		
		try {
			analyzer.prepareModel();	
			GeneratorOptions go = ProjectOptions.getProjectOptions().getGeneratorOptions().get("EJBGenerator");			
			EJBGenerator generator = new EJBGenerator(go);
			generator.generate();
			
			GeneratorOptions htmlGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("HTMLGenerator");			
			HTMLGenerator htmlGenerator = new HTMLGenerator(htmlGo);
			htmlGenerator.generate();
			
			GeneratorOptions jsControllerGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("JSControllerGenerator");			
			JSControllerGenerator jsControllerGenerator = new JSControllerGenerator(jsControllerGo);
			jsControllerGenerator.generate();
			
			GeneratorOptions jsServiceGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("JSServiceGenerator");			
			JSServiceGenerator jsServiceGenerator = new JSServiceGenerator(jsServiceGo);
			jsServiceGenerator.generate();
			
			GeneratorOptions jsAppGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("JSAppGenerator");			
			JSAppGenerator jsAppGenerator = new JSAppGenerator(jsAppGo);
			jsAppGenerator.generate();
			
			GeneratorOptions jsDirectivesGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("JSDirectivesGenerator");			
			JSAppGenerator jsDirectivesGenerator = new JSAppGenerator(jsDirectivesGo);
			jsDirectivesGenerator.generate();
			
			GeneratorOptions jsControllersGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("JSControllersGenerator");			
			JSAppGenerator jsControllersGenerator = new JSAppGenerator(jsControllersGo);
			jsControllersGenerator.generate();
			
			GeneratorOptions jsServicesGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("JSServicesGenerator");			
			JSAppGenerator jsServicesGenerator = new JSAppGenerator(jsServicesGo);
			jsServicesGenerator.generate();
			
			GeneratorOptions jsRoutesGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("JSRoutesGenerator");			
			JSAppGenerator jsRoutesGenerator = new JSAppGenerator(jsRoutesGo);
			jsRoutesGenerator.generate();
			
			GeneratorOptions jsIndexGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("JSIndexGenerator");			
			JSAppGenerator jsIndexGenerator = new JSAppGenerator(jsIndexGo);
			jsIndexGenerator.generate();
			
			GeneratorOptions homeGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("HomeGenerator");			
			JSAppGenerator homeGenerator = new JSAppGenerator(homeGo);
			homeGenerator.generate();
			
			GeneratorOptions controllerGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("ControllerGenerator");			
			ControllerGenerator controllerGenerator = new ControllerGenerator(controllerGo);
			controllerGenerator.generate();
			
			GeneratorOptions repositoryGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("RepositoryGenerator");			
			RepositoryGenerator repositoryGenerator = new RepositoryGenerator(repositoryGo);
			repositoryGenerator.generate();
			
			GeneratorOptions serviceGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("ServiceGenerator");			
			ServiceGenerator serviceGenerator = new ServiceGenerator(serviceGo);
			serviceGenerator.generate();
			
			GeneratorOptions serviceImplGo = ProjectOptions.getProjectOptions().getGeneratorOptions().get("ServiceImplGenerator");			
			ServiceImplGenerator serviceImplGenerator = new ServiceImplGenerator(serviceImplGo);
			serviceImplGenerator.generate();
			
			
			/**  @ToDo: Also call other generators */ 
			JOptionPane.showMessageDialog(null, "Code is successfully generated! Generated code is in folder: " + go.getOutputPath() +
					                         " package: " + go.getFilePackage());
			exportToXml();
		} catch (AnalyzeException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		} 			
	}
	
	private void exportToXml() {
		if (JOptionPane.showConfirmDialog(null, "Do you want to extract model metadata?") == 
			JOptionPane.OK_OPTION)
		{	
			JFileChooser jfc = new JFileChooser();
			if (jfc.showSaveDialog(null) == JFileChooser.APPROVE_OPTION) {
				String fileName = jfc.getSelectedFile().getAbsolutePath();
			
				XStream xstream = new XStream(new DomDriver());
				BufferedWriter out;		
				try {
					out = new BufferedWriter(new OutputStreamWriter(
							new FileOutputStream(fileName), "UTF8"));					
					xstream.toXML(FMModel.getInstance().getClasses(), out);
					xstream.toXML(FMModel.getInstance().getEnumerations(), out);
					JOptionPane.showMessageDialog(null, "Metadata successfully extracted!");
					
				} catch (UnsupportedEncodingException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());				
				} catch (FileNotFoundException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());				
				}		             
			}
		}	
	}	  

}