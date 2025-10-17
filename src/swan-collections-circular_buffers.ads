generic
   Max : Positive;
   Allow_Overwrite : Boolean := False;
   type T is private;
package Swan.Collections.Circular_Buffers is

   type Circular_Buffer is limited private;
   --  Simple circular buffer implementation, by default it will prevent
   --  overwrites this can be altered by setting Allow_Overwrite to True,
   --  otherwise a write that would cause an overwrite
   --  will instead raise an Would_Overwrite exception.

   Would_Overwrite, Is_Empty : exception;

   procedure Write_Item (CB : in out Circular_Buffer; Item : T);
   --  Insert an item into the circular buffer
   --  @param CB the circular buffer to operate on
   --  @exception Would_Overwrite may be raised if the insertion
   --  would cause an overwrite of data and Allow_Overwrite is False (default)

   function Read_Item (CB : in out Circular_Buffer) return T;
   --  Gets the least recent inserted item in the buffer, this is guaranteed
   --  as long as the buffer is in no overwrite mode, otherwise FIFO ordering
   --  cannot be ensured.
   --  @param CB the circular buffer to operate on
   --  @return One item of type T
   --  @exception Is_Empty may be raised in case there is no fresh data.

   function Read_Item_Unchecked (CB : in out Circular_Buffer) return T;
   --  # SAFETY NOTE:
   --  This function might return data that was previously read, only use
   --  if you keep track of previously seen data and want to avoid a call
   --  to Is_Empty or handling the possible exception.
   --  @param CB the circular buffer to operate on
   --  @return One item of type T; possibly previously read data.

   function Check_Is_Empty (CB : Circular_Buffer) return Boolean;
   --  Checks if the circular buffer contains any unread items.
   --  @param CB the circular buffer to check
   --  @return True if the buffer is empty, False otherwise.

private
   type CB_Array is array (Natural range <>) of T;

   Min : constant := 0;

   type Circular_Buffer is record
      Container     : CB_Array (Min .. Max);
      ReadI, WriteI : Integer := Min;
   end record;

end Swan.Collections.Circular_Buffers;
