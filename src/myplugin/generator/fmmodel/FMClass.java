package myplugin.generator.fmmodel;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


public class FMClass extends FMType {	
	
	private String visibility;
	
	//Class properties
	private List<FMProperty> FMProperties = new ArrayList<FMProperty>();
	
	//UI properties
	private List<FMProperty> UIProperties = new ArrayList<FMProperty>();
	
	//Zoom properties
	private List<FMProperty> zoomProperties = new ArrayList<FMProperty>();
	
	//list of packages (for import declarations) 
	private List<String> importedPackages = new ArrayList<String>();
	
	/** @ToDo: add list of methods */
	
	
	public FMClass(String name, String classPackage, String visibility) {
		super(name, classPackage);		
		this.visibility = visibility;
	}	
	
	public List<FMProperty> getProperties(){
		return FMProperties;
	}
	
	public Iterator<FMProperty> getPropertyIterator(){
		return FMProperties.iterator();
	}
	
	public void addProperty(FMProperty property){
		FMProperties.add(property);		
	}
	
	public int getPropertyCount(){
		return FMProperties.size();
	}
	
	public List<FMProperty> getUIProperties(){
		return UIProperties;
	}
	
	public Iterator<FMProperty> getUIPropertyIterator(){
		return UIProperties.iterator();
	}
	
	public void addUIProperty(FMProperty property){
		UIProperties.add(property);		
	}
	
	public int getIOPropertyCount(){
		return UIProperties.size();
	}
	
	public List<FMProperty> getZoomProperties(){
		return zoomProperties;
	}
	
	public Iterator<FMProperty> getZoomPropertyIterator(){
		return zoomProperties.iterator();
	}
	
	public void addZoomProperty(FMProperty property){
		zoomProperties.add(property);		
	}
	
	public int getZoomPropertyCount(){
		return zoomProperties.size();
	}
	
	public List<String> getImportedPackages(){
		return importedPackages;
	}

	public Iterator<String> getImportedIterator(){
		return importedPackages.iterator();
	}
	
	public void addImportedPackage(String importedPackage){
		importedPackages.add(importedPackage);		
	}
	
	public int getImportedCount(){
		return FMProperties.size();
	}
	
	public String getVisibility() {
		return visibility;
	}

	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}	

}
