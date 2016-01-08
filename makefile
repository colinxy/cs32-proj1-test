CXX = g++

CPPFLAGS = -std=c++11 -Wall
OBJS	 = Robot.o Player.o History.o \
		   Arena.o Game.o utilities.o
SRCS	 = Arena.cpp Game.cpp History.cpp \
		   Player.cpp Robot.cpp utilities.cpp
HDRS	 = globals.h Robot.h Player.h \
		   Arena.h Game.h History.h


clean :
	rm *.o *.out

# preliminary

Robot.o : Robot.cpp Robot.h Player.h Arena.h globals.h
	$(CXX) $(CPPFLAGS) -c -o Robot.o Robot.cpp

Player.o : Player.cpp Robot.h Player.h Arena.h globals.h
	$(CXX) $(CPPFLAGS) -c -o Player.o Player.cpp

History.o : History.cpp History.h globals.h
	$(CXX) $(CPPFLAGS) -c -o History.o History.cpp

Arena.o : Arena.cpp Robot.h Player.h Arena.h globals.h
	$(CXX) $(CPPFLAGS) -c -o Arena.o Arena.cpp

Game.o : Game.cpp Game.h Robot.h Player.h Arena.h globals.h
	$(CXX) $(CPPFLAGS) -c -o Game.o Game.cpp

utilities.o : utilities.cpp globals.h
	$(CXX) $(CPPFLAGS) -c -o utilities.o utilities.cpp

# compilation test

# the following compilation should succeed
arena_h : arena_h.cpp Arena.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o arena_h.out arena_h.cpp $(OBJS)

arena_player_h : arena_player_h.cpp Arena.h Player.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o arena_player_h.out arena_player_h.cpp $(OBJS)

history_h : history_h.cpp History.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o history_h.out history_h.cpp $(OBJS)

multi_h : multi_h.cpp $(HDRS)
	$(CXX) $(CPPFLAGS) -o multi_h.out multi_h.cpp $(OBJS)

player_arena_g_h : player_arena_g_h.cpp Player.h Arena.h globals.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o player_arena_g_h.out player_arena_g_h.cpp $(OBJS)

player_arena_h : player_arena_h.cpp Player.h Arena.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o player_arena_h.out player_arena_h.cpp $(OBJS)

player_h : player_h.cpp Player.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o player_h.out player_h.cpp $(OBJS)

robot_h : robot_h.cpp Robot.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o robot_h.out robot_h.cpp $(OBJS)

# the following compilation should fail
history_FAIL_h : history_FAIL_h.cpp History.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o history_FAIL_h.out history_FAIL_h.cpp $(OBJS)

player_arena_FAIL_h : player_arena_FAIL_h.cpp Player.h Arena.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o player_arena_FAIL_h.out player_arena_FAIL_h.cpp $(OBJS)

robot_player_g_FAIL_h : robot_player_g_FAIL_h.cpp Robot.h Player.h globals.h $(SRCS)
	$(CXX) $(CPPFLAGS) -o robot_player_g_FAIL_h.out robot_player_g_FAIL_h.cpp $(OBJS)

# output test
arena_history_player_g_h : arena_history_player_g_h.cpp Arena.h History.h Player.h globals.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o arena_history_player_g_h.out arena_history_player_g_h.cpp $(OBJS)
