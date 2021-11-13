package com.sulake.habbo.freeflowchat.history.visualization.entry
{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import com.sulake.habbo.freeflowchat.history.visualization.enum._SafeStr_174;
    import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
    import flash.geom.Point;
    import flash.geom.Matrix;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;

    public class ChatHistoryRoomChangeEntry implements IChatHistoryEntryBitmap 
    {

        private static const TOP_MARGIN_HEIGHT:int = 4;

        private var _bitmap:BitmapData;
        private var _overlap:Rectangle = new Rectangle(0, 0, 0, 0);

        public function ChatHistoryRoomChangeEntry(_arg_1:GuestRoomData, _arg_2:HabboFreeFlowChat)
        {
            var _local_4:TextField = new TextField();
            _local_4.defaultTextFormat = _SafeStr_174.TEXT_FORMAT;
            _local_4.htmlText = ((_arg_1 == null) ? "null" : _arg_1.roomName);
            _local_4.width = (_local_4.textWidth + 5);
            _local_4.height = (_local_4.textHeight + 5);
            _local_4.thickness = -15;
            _local_4.sharpness = 80;
            _local_4.antiAliasType = "advanced";
            _local_4.embedFonts = true;
            _local_4.gridFitType = "pixel";
            var _local_3:TextField = new TextField();
            _local_3.defaultTextFormat = _SafeStr_174.TEXT_FORMAT_TIMESTAMP;
            _local_3.text = HabboFreeFlowChat.getTimeStampNow();
            _local_3.width = (_local_3.textWidth + 5);
            _local_3.height = (_local_3.textHeight + 5);
            _local_3.thickness = -15;
            _local_3.sharpness = 80;
            _local_3.antiAliasType = "advanced";
            _local_3.embedFonts = true;
            _local_3.gridFitType = "pixel";
            _bitmap = new BitmapData(415, (((_local_4.textHeight + 5) + 8) + 4), true, 0);
            _bitmap.copyPixels(_arg_2.getRoomChangeBitmap(), _arg_2.getRoomChangeBitmap().rect, new Point(62, (1 + 4)));
            _bitmap.draw(_local_3, new Matrix(1, 0, 0, 1, 0, 4));
            _bitmap.draw(_local_4, new Matrix(1, 0, 0, 1, (62 + 20), 4));
        }

        public function get bitmap():BitmapData
        {
            return (_bitmap);
        }

        public function get overlap():Rectangle
        {
            return (_overlap);
        }

        public function get userId():int
        {
            return (-1);
        }

        public function get roomId():int
        {
            return (-1);
        }

        public function get canIgnore():Boolean
        {
            return (false);
        }

        public function get userName():String
        {
            return ("");
        }


    }
}

