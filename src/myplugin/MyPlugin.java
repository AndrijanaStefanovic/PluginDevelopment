package myplugin;

import java.io.File;

import javax.swing.JOptionPane;

import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;


import com.nomagic.actions.NMAction;
import com.nomagic.magicdraw.actions.ActionsConfiguratorsManager;

/** MagicDraw plugin that performes code generation */
public class MyPlugin extends com.nomagic.magicdraw.plugins.Plugin {
	
	String pluginDir = null; 
	
	public void init() {
		JOptionPane.showMessageDialog( null, "My Plugin init");
		
		pluginDir = getDescriptor().getPluginDirectory().getPath();
		
		// Creating submenu in the MagicDraw main menu 	
		ActionsConfiguratorsManager manager = ActionsConfiguratorsManager.getInstance();		
		manager.addMainMenuConfigurator(new MainMenuConfigurator(getSubmenuActions()));
		
		/** @Todo: load project options (@see myplugin.generator.options.ProjectOptions) from 
		 * ProjectOptions.xml and take ejb generator options */
		
		//for test purpose only:
		GeneratorOptions ejbOptions = new GeneratorOptions("c:/temp/model", "ejbclass", "templates", "{0}.java", true, "ejb"); 
		
		GeneratorOptions htmlOptions = new GeneratorOptions("c:/temp/html", "htmlpage", "templates", "{0}.html", true, "ejb");
		
		GeneratorOptions jsControllerOptions = new GeneratorOptions("c:/temp/jsController", "jscontroller", "templates", "{0}Controller.js", true, "ejb");
		GeneratorOptions jsServiceOptions = new GeneratorOptions("c:/temp/jsService", "jsservice", "templates", "{0}Service.js", true, "ejb");
		
		GeneratorOptions jsAppOptions = new GeneratorOptions("c:/temp", "jsapp", "templates", "app.js", true, "ejb");
		GeneratorOptions jsDirectivesOptions = new GeneratorOptions("c:/temp", "jsdirectives", "templates", "directives.js", true, "ejb");
		GeneratorOptions jsControllersOptions = new GeneratorOptions("c:/temp", "jscontrollers", "templates", "controllers.js", true, "ejb");
		GeneratorOptions jsServicesOptions = new GeneratorOptions("c:/temp", "jsservices", "templates", "services.js", true, "ejb");
		GeneratorOptions jsRoutesOptions = new GeneratorOptions("c:/temp", "jsroutes", "templates", "routes.js", true, "ejb");
		GeneratorOptions jsIndexOptions = new GeneratorOptions("c:/temp", "jsindex", "templates", "index.html", true, "ejb");
		
		GeneratorOptions controllerOptions = new GeneratorOptions("c:/temp/controller", "controller", "templates", "{0}Controller.java", true, "ejb");
		
		GeneratorOptions repositoryOptions = new GeneratorOptions("c:/temp/repository", "repository", "templates", "{0}Repository.java", true, "ejb");
		GeneratorOptions serviceOptions = new GeneratorOptions("c:/temp/service", "service", "templates", "{0}Service.java", true, "ejb");
		GeneratorOptions serviceImplOptions = new GeneratorOptions("c:/temp/service/impl", "serviceimpl", "templates", "{0}ServiceImpl.java", true, "ejb");
		
		
		
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("EJBGenerator", ejbOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("HTMLGenerator", htmlOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("JSControllerGenerator", jsControllerOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("JSServiceGenerator", jsServiceOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("JSAppGenerator", jsAppOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("JSDirectivesGenerator", jsDirectivesOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("JSControllersGenerator", jsControllersOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("JSServicesGenerator", jsServicesOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("JSRoutesGenerator", jsRoutesOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("JSIndexGenerator", jsIndexOptions);
		
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("ControllerGenerator", controllerOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("RepositoryGenerator", repositoryOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("ServiceGenerator", serviceOptions);
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("ServiceImplGenerator", serviceImplOptions);
		
		ejbOptions.setTemplateDir(pluginDir + File.separator + ejbOptions.getTemplateDir()); //apsolutna putanja
		htmlOptions.setTemplateDir(pluginDir + File.separator + htmlOptions.getTemplateDir());
		jsControllerOptions.setTemplateDir(pluginDir + File.separator + jsControllerOptions.getTemplateDir());
		jsServiceOptions.setTemplateDir(pluginDir + File.separator + jsServiceOptions.getTemplateDir());
		jsAppOptions.setTemplateDir(pluginDir + File.separator + jsAppOptions.getTemplateDir());
		jsDirectivesOptions.setTemplateDir(pluginDir + File.separator + jsDirectivesOptions.getTemplateDir());
		jsControllersOptions.setTemplateDir(pluginDir + File.separator + jsControllersOptions.getTemplateDir());
		jsServicesOptions.setTemplateDir(pluginDir + File.separator + jsServicesOptions.getTemplateDir());
		jsRoutesOptions.setTemplateDir(pluginDir + File.separator + jsRoutesOptions.getTemplateDir());
		jsIndexOptions.setTemplateDir(pluginDir + File.separator + jsIndexOptions.getTemplateDir());
		
		controllerOptions.setTemplateDir(pluginDir + File.separator + controllerOptions.getTemplateDir());
		
		repositoryOptions.setTemplateDir(pluginDir + File.separator + repositoryOptions.getTemplateDir());
		serviceOptions.setTemplateDir(pluginDir + File.separator + serviceOptions.getTemplateDir());
		serviceImplOptions.setTemplateDir(pluginDir + File.separator + serviceImplOptions.getTemplateDir());
		
	}

	private NMAction[] getSubmenuActions()
	{
	   return new NMAction[]{
			new GenerateAction("Generate"),
	   };
	}
	
	public boolean close() {
		return true;
	}
	
	public boolean isSupported() {				
		return true;
	}
}


