module cache #(
    // parameters
) (
    // port_list
);

typedef struct packed {
    // | v | tag | data |
    // | [57] | [56:32] | [31:0] |
    logic v;
    logic [23:0] tag; // what is a tag? how long do i want my tag to be?
    logic [31:0] data;
} direct_mapped_cache_line_t;

typedef struct packed {
    // two way set
} two_way_set_associative_cache_line_t;

typedef struct packed {
    // three way set
} three_way_set_associative_cache_line_t;

endmodule
