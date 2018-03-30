package myplugin.generator.fmmodel;

public class FMAssociation extends FMElement{

	private FMProperty firstEnd;
	private FMProperty secondEnd;
	
	public FMAssociation(String name) {
		super(name);
		// TODO Auto-generated constructor stub
	}

	public FMProperty getFirstEnd() {
		return firstEnd;
	}

	public void setFirstEnd(FMProperty firstEnd) {
		this.firstEnd = firstEnd;
	}

	public FMProperty getSecondEnd() {
		return secondEnd;
	}

	public void setSecondEnd(FMProperty secondEnd) {
		this.secondEnd = secondEnd;
	}

}
