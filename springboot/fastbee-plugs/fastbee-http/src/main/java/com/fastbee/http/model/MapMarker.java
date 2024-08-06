package com.fastbee.http.model;

import lombok.Data;

import java.util.List;

@Data
public class MapMarker {

    private List<marker> markers;

    @Data
    public static class marker {
        private String name;
        private Integer value;
        private List<Float> position;
    }
}
