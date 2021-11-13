package com.sulake.habbo.game
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosedMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosingMessageEvent;
    import com.sulake.habbo.communication.messages.parser.availability.MaintenanceStatusMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class IncomingMessages implements IDisposable 
    {

        private var _gameManager:HabboGameManager;
        private var _disposed:Boolean = false;

        public function IncomingMessages(_arg_1:HabboGameManager)
        {
            _gameManager = _arg_1;
            var _local_2:IHabboCommunicationManager = _gameManager.communication;
            _local_2.addHabboConnectionMessageEvent(new InfoHotelClosedMessageEvent(onHotelClosed));
            _local_2.addHabboConnectionMessageEvent(new InfoHotelClosingMessageEvent(onHotelClosed));
            _local_2.addHabboConnectionMessageEvent(new MaintenanceStatusMessageEvent(onHotelClosed));
        }

        public function dispose():void
        {
            _gameManager = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function onHotelClosed(_arg_1:IMessageEvent):void
        {
            _gameManager.hotelClosed = true;
        }


    }
}