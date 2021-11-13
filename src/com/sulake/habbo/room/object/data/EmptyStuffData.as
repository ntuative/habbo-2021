package com.sulake.habbo.room.object.data
{
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.IRoomObjectModelController;

    public class EmptyStuffData extends StuffDataBase implements IStuffData 
    {


        override public function initializeFromIncomingMessage(_arg_1:IMessageDataWrapper):void
        {
            super.initializeFromIncomingMessage(_arg_1);
        }

        override public function initializeFromRoomObjectModel(_arg_1:IRoomObjectModel):void
        {
            super.initializeFromRoomObjectModel(_arg_1);
        }

        override public function writeRoomObjectModel(_arg_1:IRoomObjectModelController):void
        {
            super.writeRoomObjectModel(_arg_1);
        }

        override public function getLegacyString():String
        {
            return ("");
        }

        override public function compare(_arg_1:IStuffData):Boolean
        {
            return (super.compare(_arg_1));
        }


    }
}