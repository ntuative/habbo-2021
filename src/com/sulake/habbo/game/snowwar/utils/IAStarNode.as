package com.sulake.habbo.game.snowwar.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.game.snowwar.arena.IGameObject;

    public /*dynamic*/ interface IAStarNode extends IDisposable 
    {

        function distanceTo(_arg_1:IAStarNode):int;
        function directionTo(_arg_1:IAStarNode):Direction8;
        function getNodeAt(_arg_1:Direction8):IAStarNode;
        function directionIsBlocked(_arg_1:Direction8, _arg_2:IGameObject):Boolean;
        function getPathCost(_arg_1:Direction8, _arg_2:IGameObject):int;
        function set nodeDirection(_arg_1:Direction8):void;
        function get nodeDirection():Direction8;
        function set parentNode(_arg_1:IAStarNode):void;
        function get parentNode():IAStarNode;
        function set nodeCostFromStart(_arg_1:int):void;
        function get nodeCostFromStart():int;
        function set nodeCostToGoal(_arg_1:int):void;
        function get nodeCostToGoal():int;

    }
}