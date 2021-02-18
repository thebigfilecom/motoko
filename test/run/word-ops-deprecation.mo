// deprecated
ignore (func (a : Word8){ignore (a + a)});
ignore (func (a : Word8){ignore (a - a)});
ignore (func (a : Word8){ignore (a * a)});
ignore (func (a : Word8){ignore (a ** a)});
ignore (func (a : Word16){ignore (a + a)});
ignore (func (a : Word16){ignore (a - a)});
ignore (func (a : Word16){ignore (a * a)});
ignore (func (a : Word16){ignore (a ** a)});
ignore (func (a : Word32){ignore (a + a)});
ignore (func (a : Word32){ignore (a - a)});
ignore (func (a : Word32){ignore (a * a)});
ignore (func (a : Word32){ignore (a ** a)});
ignore (func (a : Word64){ignore (a + a)});
ignore (func (a : Word64){ignore (a - a)});
ignore (func (a : Word64){ignore (a * a)});
ignore (func (a : Word64){ignore (a ** a)});

// and now the same in checking mode
ignore (func (a : Word8) : Word8 {(a + a)});
ignore (func (a : Word8) : Word8 {(a - a)});
ignore (func (a : Word8) : Word8 {(a * a)});
ignore (func (a : Word8) : Word8 {(a ** a)});
ignore (func (a : Word16) : Word16 {(a + a)});
ignore (func (a : Word16) : Word16 {(a - a)});
ignore (func (a : Word16) : Word16 {(a * a)});
ignore (func (a : Word16) : Word16 {(a ** a)});
ignore (func (a : Word32) : Word32 {(a + a)});
ignore (func (a : Word32) : Word32 {(a - a)});
ignore (func (a : Word32) : Word32 {(a * a)});
ignore (func (a : Word32) : Word32 {(a ** a)});
ignore (func (a : Word64) : Word64 {(a + a)});
ignore (func (a : Word64) : Word64 {(a - a)});
ignore (func (a : Word64) : Word64 {(a * a)});
ignore (func (a : Word64) : Word64 {(a ** a)});

// not deprecated
ignore (func (a : Word8){ignore (-a)});
ignore (func (a : Word8){ignore (a / a)});
ignore (func (a : Word8){ignore (a % a)});
ignore (func (a : Word8){ignore (a +% a)});
ignore (func (a : Word8){ignore (a -% a)});
ignore (func (a : Word8){ignore (a *% a)});
ignore (func (a : Word8){ignore (a **% a)});
ignore (func (a : Word16){ignore (-a)});
ignore (func (a : Word16){ignore (a / a)});
ignore (func (a : Word16){ignore (a % a)});
ignore (func (a : Word16){ignore (a +% a)});
ignore (func (a : Word16){ignore (a -% a)});
ignore (func (a : Word16){ignore (a *% a)});
ignore (func (a : Word16){ignore (a **% a)});
ignore (func (a : Word32){ignore (-a)});
ignore (func (a : Word32){ignore (a / a)});
ignore (func (a : Word32){ignore (a % a)});
ignore (func (a : Word32){ignore (a +% a)});
ignore (func (a : Word32){ignore (a -% a)});
ignore (func (a : Word32){ignore (a *% a)});
ignore (func (a : Word32){ignore (a **% a)});
ignore (func (a : Word64){ignore (-a)});
ignore (func (a : Word64){ignore (a / a)});
ignore (func (a : Word64){ignore (a % a)});
ignore (func (a : Word64){ignore (a +% a)});
ignore (func (a : Word64){ignore (a -% a)});
ignore (func (a : Word64){ignore (a *% a)});
ignore (func (a : Word64){ignore (a **% a)});


// also not deprecated
ignore (func (a : Nat8){ignore (a * a)});
ignore (func (a : Nat8){ignore (a *% a)});
ignore (func (a : Nat8){ignore (a ** a)});
ignore (func (a : Nat8){ignore (a **% a)});
ignore (func (a : Nat8){ignore (a + a)});
ignore (func (a : Nat8){ignore (a +% a)});
ignore (func (a : Nat8){ignore (a - a)});
ignore (func (a : Nat8){ignore (a -% a)});
ignore (func (a : Nat8){ignore (a / a)});
ignore (func (a : Nat8){ignore (a % a)});
ignore (func (a : Nat16){ignore (a * a)});
ignore (func (a : Nat16){ignore (a *% a)});
ignore (func (a : Nat16){ignore (a ** a)});
ignore (func (a : Nat16){ignore (a **% a)});
ignore (func (a : Nat16){ignore (a + a)});
ignore (func (a : Nat16){ignore (a +% a)});
ignore (func (a : Nat16){ignore (a - a)});
ignore (func (a : Nat16){ignore (a -% a)});
ignore (func (a : Nat16){ignore (a / a)});
ignore (func (a : Nat16){ignore (a % a)});
ignore (func (a : Nat32){ignore (a * a)});
ignore (func (a : Nat32){ignore (a *% a)});
ignore (func (a : Nat32){ignore (a ** a)});
ignore (func (a : Nat32){ignore (a **% a)});
ignore (func (a : Nat32){ignore (a + a)});
ignore (func (a : Nat32){ignore (a +% a)});
ignore (func (a : Nat32){ignore (a - a)});
ignore (func (a : Nat32){ignore (a -% a)});
ignore (func (a : Nat32){ignore (a / a)});
ignore (func (a : Nat32){ignore (a % a)});
ignore (func (a : Nat64){ignore (a * a)});
ignore (func (a : Nat64){ignore (a *% a)});
ignore (func (a : Nat64){ignore (a ** a)});
ignore (func (a : Nat64){ignore (a **% a)});
ignore (func (a : Nat64){ignore (a + a)});
ignore (func (a : Nat64){ignore (a +% a)});
ignore (func (a : Nat64){ignore (a - a)});
ignore (func (a : Nat64){ignore (a -% a)});
ignore (func (a : Nat64){ignore (a / a)});
ignore (func (a : Nat64){ignore (a % a)});


ignore (func (a : Int8){ignore (-a)});
ignore (func (a : Int8){ignore (a * a)});
ignore (func (a : Int8){ignore (a *% a)});
ignore (func (a : Int8){ignore (a ** a)});
ignore (func (a : Int8){ignore (a **% a)});
ignore (func (a : Int8){ignore (a + a)});
ignore (func (a : Int8){ignore (a +% a)});
ignore (func (a : Int8){ignore (a - a)});
ignore (func (a : Int8){ignore (a -% a)});
ignore (func (a : Int8){ignore (a / a)});
ignore (func (a : Int8){ignore (a % a)});
ignore (func (a : Int16){ignore (-a)});
ignore (func (a : Int16){ignore (a * a)});
ignore (func (a : Int16){ignore (a *% a)});
ignore (func (a : Int16){ignore (a ** a)});
ignore (func (a : Int16){ignore (a **% a)});
ignore (func (a : Int16){ignore (a + a)});
ignore (func (a : Int16){ignore (a +% a)});
ignore (func (a : Int16){ignore (a - a)});
ignore (func (a : Int16){ignore (a -% a)});
ignore (func (a : Int16){ignore (a / a)});
ignore (func (a : Int16){ignore (a % a)});
ignore (func (a : Int32){ignore (-a)});
ignore (func (a : Int32){ignore (a * a)});
ignore (func (a : Int32){ignore (a *% a)});
ignore (func (a : Int32){ignore (a ** a)});
ignore (func (a : Int32){ignore (a **% a)});
ignore (func (a : Int32){ignore (a + a)});
ignore (func (a : Int32){ignore (a +% a)});
ignore (func (a : Int32){ignore (a - a)});
ignore (func (a : Int32){ignore (a -% a)});
ignore (func (a : Int32){ignore (a / a)});
ignore (func (a : Int32){ignore (a % a)});
ignore (func (a : Int64){ignore (-a)});
ignore (func (a : Int64){ignore (a * a)});
ignore (func (a : Int64){ignore (a *% a)});
ignore (func (a : Int64){ignore (a ** a)});
ignore (func (a : Int64){ignore (a **% a)});
ignore (func (a : Int64){ignore (a + a)});
ignore (func (a : Int64){ignore (a +% a)});
ignore (func (a : Int64){ignore (a - a)});
ignore (func (a : Int64){ignore (a -% a)});
ignore (func (a : Int64){ignore (a / a)});
ignore (func (a : Int64){ignore (a % a)});
