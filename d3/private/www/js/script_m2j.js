function m2j(m) {
    var j = [];
    var k = Object.keys(m);
    for(var i1=0; i1<m[k[1]].length; i1++) {
        j[i1] = {};
        for(var i2=0; i2<k.length; i2++) {
            j[i1][k[i2]] = m[k[i2]][i1];
        }
    }
    return j;
}
