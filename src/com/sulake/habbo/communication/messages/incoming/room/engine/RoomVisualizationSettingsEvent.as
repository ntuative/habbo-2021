package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomVisualizationSettingsParser;

        public class RoomVisualizationSettingsEvent extends MessageEvent 
    {

        public function RoomVisualizationSettingsEvent(_arg_1:Function)
        {
            super(_arg_1, RoomVisualizationSettingsParser);
        }

        public function getParser():RoomVisualizationSettingsParser
        {
            return (_SafeStr_816 as RoomVisualizationSettingsParser);
        }


    }
}

