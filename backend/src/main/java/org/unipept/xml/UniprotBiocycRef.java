package org.unipept.xml;

public class UniprotBiocycRef {
    private String dbId;
    private String proteinId;

    public UniprotBiocycRef(String refId) {
        String[] split = refId.split(":");
        this.dbId = split[0];
        this.proteinId = split[1];
    }

    public String getDbId() {
        return dbId;
    }

    public String getProteinId() {
        return proteinId;
    }

}
