package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import com.nomagic.magicdraw.core.Application;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;

public class ServiceImplGenerator extends BasicGenerator{

	public ServiceImplGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}
	
	public void generate() {
		
		try {
			super.generate();
		} catch (IOException e) {		
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
		
		List<FMClass> classes = FMModel.getInstance().getClasses();
		for (int i = 0; i < classes.size(); i++) {
				FMClass cl = classes.get(i);	
				Writer out;
				Map<String, Object> context = new HashMap<String, Object>();
				try {
					out = getWriter(cl.getName(), cl.getTypePackage());
					if (out != null) {
						context.clear();
						context.put("class", cl);
						context.put("properties", cl.getProperties());	
						context.put("zoomProperties", cl.getZoomProperties());
						context.put("nextProperties", cl.getNextProperties());
						context.put("importedPackages", cl.getImportedPackages());
						context.put("currentDate", new Date().toString());
						getTemplate().process(context, out);
						out.flush();
					}
				} catch (TemplateException e) {	
					JOptionPane.showMessageDialog(null, e.getMessage());
				}	
				catch (IOException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());
				}	
			}
		}

}
