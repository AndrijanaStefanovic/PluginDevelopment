package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import com.nomagic.uml2.ext.jmi.helpers.StereotypesHelper;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;

public class HTMLGenerator extends BasicGenerator {

	public HTMLGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
		// TODO Auto-generated constructor stub
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
						context.put("uiProperies", cl.getUIProperties());	//Na html sablonu su potrebni UI properties	
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
