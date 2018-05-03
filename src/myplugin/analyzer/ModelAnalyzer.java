package myplugin.analyzer;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.swing.JOptionPane;

import com.nomagic.uml2.ext.jmi.helpers.ModelHelper;
import com.nomagic.uml2.ext.jmi.helpers.StereotypesHelper;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Association;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Class;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Element;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Enumeration;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.EnumerationLiteral;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Property;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Type;
import com.nomagic.uml2.ext.magicdraw.mdprofiles.Stereotype;

import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMEnumeration;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMProperty;


/** Model Analyzer takes necessary metadata from the MagicDraw model and puts it in 
 * the intermediate data structure (@see myplugin.generator.fmmodel.FMModel) optimized
 * for code generation using freemarker. Model Analyzer now takes metadata only for ejb code 
 * generation

 * @ToDo: Enhance (or completely rewrite) myplugin.generator.fmmodel classes and  
 * Model Analyzer methods in order to support GUI generation. */ 


public class ModelAnalyzer {	
	//root model package
	private Package root;
	
	//java root package for generated code
	private String filePackage;
	
	public ModelAnalyzer(Package root, String filePackage) {
		super();
		this.root = root;
		this.filePackage = filePackage;
	}

	public Package getRoot() {
		return root;
	}
	
	public void prepareModel() throws AnalyzeException {
		FMModel.getInstance().getClasses().clear();
		FMModel.getInstance().getEnumerations().clear();
		processPackage(root, filePackage);
	}
	
	private void processPackage(Package pack, String packageOwner) throws AnalyzeException {
		//Recursive procedure that extracts data from package elements and stores it in the 
		// intermediate data structure
		
		if (pack.getName() == null) throw  
			new AnalyzeException("Packages must have names!");
		
		String packageName = packageOwner;
		if (pack != root) {
			packageName += "." + pack.getName();
		}
		
		if (pack.hasOwnedElement()) {
			
			for (Iterator<Element> it = pack.getOwnedElement().iterator(); it.hasNext();) {
				Element ownedElement = it.next();
				if (ownedElement instanceof Class) {
					Class cl = (Class)ownedElement;
					FMClass fmClass = getClassData(cl, packageName);
					FMModel.getInstance().getClasses().add(fmClass);
				}
				
				if (ownedElement instanceof Enumeration) {
					Enumeration en = (Enumeration)ownedElement;
					FMEnumeration fmEnumeration = getEnumerationData(en, packageName);
					FMModel.getInstance().getEnumerations().add(fmEnumeration);
				}
			}
			
			for (Iterator<Element> it = pack.getOwnedElement().iterator(); it.hasNext();) {
				Element ownedElement = it.next();
				if (ownedElement instanceof Package) {					
					Package ownedPackage = (Package)ownedElement;
					if (StereotypesHelper.getAppliedStereotypeByString(ownedPackage, "BusinessApp") != null)
						//only packages with stereotype BusinessApp are candidates for metadata extraction and code generation:
						processPackage(ownedPackage, packageName);
				}
			}
			
			/** @ToDo:
			  * Process other package elements, as needed */ 
		}
	}
	
	private FMClass getClassData(Class cl, String packageName) throws AnalyzeException {
		
		if (cl.getName() == null) 
			throw new AnalyzeException("Classes must have names!");
		
		FMClass fmClass = new FMClass(cl.getName(), packageName, cl.getVisibility().toString());
		Iterator<Property> it = ModelHelper.attributes(cl);
		while (it.hasNext()) {
			Property p = it.next();
			FMProperty prop = getPropertyData(p, cl);
			fmClass.addProperty(prop);	
			if(prop.isUiProperty()){
				fmClass.addUIProperty(prop);
			}
			if(prop.isZoom()){
				fmClass.addZoomProperty(prop);
			}
		}	
				
		/** @ToDo:
		 * Add import declarations etc. */		
		return fmClass;
	}
	
	private FMProperty getPropertyData(Property p, Class cl) throws AnalyzeException {
		String attName = p.getName();
		if (attName == null) 
			throw new AnalyzeException("Properties of the class: " + cl.getName() +
					" must have names!");
		Type attType = p.getType();
		if (attType == null)
			throw new AnalyzeException("Property " + cl.getName() + "." +
			p.getName() + " must have type!");
		
		String typeName = attType.getName();
		if (typeName == null)
			throw new AnalyzeException("Type ot the property " + cl.getName() + "." +
			p.getName() + " must have name!");		
			
		int lower = p.getLower();
		int upper = p.getUpper();
		
		//Podrazumevane vrednosti
		boolean readonly = false;
		int length = 0;
		String componentKind = "";
		int precision = 0;
		boolean uiProperty = false;
		String label = p.getName();
		Stereotype propertyStereotype = StereotypesHelper.getAppliedStereotypeByString(p, "Editable");
		
		if (propertyStereotype == null) {
			propertyStereotype = StereotypesHelper.getAppliedStereotypeByString(p, "Readonly");
			readonly = true;
		} 
		
		if (propertyStereotype != null) { //has Readonly or Editable
			uiProperty = true;
			List lengthList = StereotypesHelper.getStereotypePropertyValue(p, propertyStereotype, "length");
			if(!lengthList.isEmpty()) {
				length = (Integer)lengthList.get(0);
			}
			List componentList = StereotypesHelper.getStereotypePropertyValue(p, propertyStereotype, "component");
			if(!componentList.isEmpty()) {
				componentKind = ((EnumerationLiteral)componentList.get(0)).getName();
			}
			List precisionList = StereotypesHelper.getStereotypePropertyValue(p, propertyStereotype, "precision");
			if(!precisionList.isEmpty()) {
				precision = (Integer)precisionList.get(0);
			}
			List labelList = StereotypesHelper.getStereotypePropertyValue(p, propertyStereotype, "label");
			if(!labelList.isEmpty()) {
				label = labelList.get(0).toString();
			}
		}
		
		boolean perProperty = false;
		boolean nullable = true;
		Stereotype persistantProperty = StereotypesHelper.getAppliedStereotypeByString(p, "PersistantProperty");
		if(persistantProperty != null){
			perProperty = true;
			List nullableList = StereotypesHelper.getStereotypePropertyValue(p, persistantProperty, "nullable");
			if(!nullableList.isEmpty()) {
				 nullable = (Boolean)nullableList.get(0);
			}
		}
		
		
		FMProperty prop = new FMProperty(attName, typeName, p.getVisibility().toString(), 
				lower, upper, readonly, length, precision, componentKind, uiProperty, label, false,
				perProperty, nullable);
		
		
		Stereotype zoomStereotype = StereotypesHelper.getAppliedStereotypeByString(p, "Zoom");
		if( zoomStereotype != null){
			prop.setZoom(true);
			List showPropertiesList = StereotypesHelper.getStereotypePropertyValue(p, zoomStereotype, "show");
			if(!showPropertiesList.isEmpty()) {
				String showPropertiesString = showPropertiesList.get(0).toString();
				String tokens[] = showPropertiesString.split(",");
				for(String token : tokens) {
					prop.addShowProperty(token.trim());
				}
			}
		} 
	
		return prop;		
	}	
	
	private FMEnumeration getEnumerationData(Enumeration enumeration, String packageName) throws AnalyzeException {
		FMEnumeration fmEnum = new FMEnumeration(enumeration.getName(), packageName);
		List<EnumerationLiteral> list = enumeration.getOwnedLiteral();
		for (int i = 0; i < list.size() - 1; i++) {
			EnumerationLiteral literal = list.get(i);
			if (literal.getName() == null)  
				throw new AnalyzeException("Items of the enumeration " + enumeration.getName() +
				" must have names!");
			fmEnum.addValue(literal.getName());
		}
		return fmEnum;
	}	
		
	
}
