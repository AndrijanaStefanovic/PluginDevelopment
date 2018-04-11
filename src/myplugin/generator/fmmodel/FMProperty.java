package myplugin.generator.fmmodel;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class FMProperty extends FMElement  {
	//Property type
	private String type;
	// Property visibility (public, private, protected, package)
	private String visibility;
	//Multiplicity (lower value)
	private Integer lower;
	//Multiplicity (upper value) 
	private Integer upper;
	
	private boolean uiProperty;
	
	private boolean readonly;
	
	private Integer length;
	
	private Integer precision;
	
	private String componentKind;
	
	private String label;
	
	private boolean zoom;
	
	private List<String> showProperties = new ArrayList<String>();
	
	/** @ToDo: Add length, precision, unique... whatever is needed for ejb class generation
	 * Also, provide these meta-attributes or tags in the modeling languange metaclass or 
	 * stereotype */

	
	public FMProperty(String name, String type, String visibility, int lower, int upper, boolean readonly,
			int length, int precision, String componentKind, boolean uiProperty, String label, boolean zoom) {
		super(name);
		this.type = type;
		this.visibility = visibility;
		
		this.lower = lower;
		this.upper = upper;		
		
		this.readonly = readonly;
		this.length = length;
		this.precision = precision;
		this.componentKind = componentKind;
		this.uiProperty = uiProperty;
		this.label = label;
		this.zoom = zoom; 
	}
	
	public boolean isZoom() {
		return zoom;
	}

	public void setZoom(boolean zoom) {
		this.zoom = zoom;
	}

	public boolean isUiProperty() {
		return uiProperty;
	}

	public void setUiProperty(boolean uiProperty) {
		this.uiProperty = uiProperty;
	}

	public boolean isReadonly() {
		return readonly;
	}

	public void setReadonly(boolean readonly) {
		this.readonly = readonly;
	}

	public Integer getLength() {
		return length;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	public Integer getPrecision() {
		return precision;
	}

	public void setPrecision(Integer precision) {
		this.precision = precision;
	}

	public String getComponentKind() {
		return componentKind;
	}

	public void setComponentKind(String componentKind) {
		this.componentKind = componentKind;
	}

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getVisibility() {
		return visibility;
	}
	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}
	
	public Integer getLower() {
		return lower;
	}

	public void setLower(Integer lower) {
		this.lower = lower;
	}

	public Integer getUpper() {
		return upper;
	}

	public void setUpper(Integer upper) {
		this.upper = upper;
	}
	
	public List<String> getShowProperties(){
		return showProperties;
	}
	
	public Iterator<String> getShowPropertyIterator(){
		return showProperties.iterator();
	}
	
	public void addShowProperty(String showProperty){
		showProperties.add(showProperty);		
	}
	
	public int getShowPropertiesCount(){
		return showProperties.size();
	}
}
