module cache #(
    // parameters
) (
    // port_list
);

typedef struct packed { // word-addressable
    /* two-way set associative cache
        Way 1:  | v | u | tag | data |
        Way 2:  | v | u | tag | data |
                | [90] | [89] | [88:64] | [63:32][31:0] | 
        Each cache:
            | tag | set | block offset | byte offset |
            | a[31:7] | a[6:3] | a[2] | a[1:0] |
    /*/
    logic valid;
    logic use;
    logic [] tag;
    logic [] data;
    
} two_way_set_associative_cache_line_t;

endmodule
