package com.sulake.habbo.communication.messages.outgoing.camera
{
        public class RenderRoomThumbnailMessageComposer extends RenderRoomMessageComposer 
    {

        public function RenderRoomThumbnailMessageComposer(_arg_1:Array, _arg_2:String, _arg_3:String, _arg_4:int, _arg_5:int)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            compressData();
        }

    }
}