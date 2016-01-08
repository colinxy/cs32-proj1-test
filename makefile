CXX = g++

CPPFLAGS = -std=c++11 -Wall
OBJS	 = Robot.o Player.o History.o \
           Arena.o Game.o utilities.o
SRCS	 = test/Arena.cpp test/Game.cpp test/History.cpp \
           test/Player.cpp test/Robot.cpp test/utilities.cpp
HDRS	 = test/globals.h test/Robot.h test/Player.h \
           test/Arena.h test/Game.h test/History.h


clean :
	rm *.o *.out

# preliminary

Robot.o : test/Robot.cpp test/Robot.h test/Player.h test/Arena.h test/globals.h
	$(CXX) $(CPPFLAGS) -c -o Robot.o test/Robot.cpp

Player.o : test/Player.cpp test/Robot.h test/Player.h test/Arena.h test/globals.h
	$(CXX) $(CPPFLAGS) -c -o Player.o test/Player.cpp

History.o : test/History.cpp test/History.h test/globals.h
	$(CXX) $(CPPFLAGS) -c -o History.o test/History.cpp

Arena.o : test/Arena.cpp test/Robot.h test/Player.h test/Arena.h test/globals.h
	$(CXX) $(CPPFLAGS) -c -o Arena.o test/Arena.cpp

Game.o : test/Game.cpp test/Game.h test/Robot.h test/Player.h test/Arena.h test/globals.h
	$(CXX) $(CPPFLAGS) -c -o Game.o test/Game.cpp

utilities.o : test/utilities.cpp test/globals.h
	$(CXX) $(CPPFLAGS) -c -o utilities.o test/utilities.cpp

# compilation test

# the following compilation should succeed
arena_h : test/arena_h.cpp test/Arena.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o arena_h.out test/arena_h.cpp $(OBJS)

arena_player_h : test/arena_player_h.cpp test/Arena.h test/Player.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o arena_player_h.out test/arena_player_h.cpp $(OBJS)

history_h : test/history_h.cpp test/History.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o history_h.out test/history_h.cpp $(OBJS)

multi_h : test/multi_h.cpp $(HDRS)
	$(CXX) $(CPPFLAGS) -o multi_h.out test/multi_h.cpp $(OBJS)

player_arena_g_h : test/player_arena_g_h.cpp test/Player.h test/Arena.h test/globals.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o player_arena_g_h.out test/player_arena_g_h.cpp $(OBJS)

player_arena_h : test/player_arena_h.cpp test/Player.h test/Arena.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o player_arena_h.out test/player_arena_h.cpp $(OBJS)

player_h : test/player_h.cpp test/Player.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o player_h.out test/player_h.cpp $(OBJS)

robot_h : test/robot_h.cpp test/Robot.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o robot_h.out test/robot_h.cpp $(OBJS)

# the following compilation should fail
history_FAIL_h : test/history_FAIL_h.cpp test/History.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o history_FAIL_h.out test/history_FAIL_h.cpp $(OBJS)

player_arena_FAIL_h : test/player_arena_FAIL_h.cpp test/Player.h test/Arena.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o player_arena_FAIL_h.out test/player_arena_FAIL_h.cpp $(OBJS)

robot_player_g_FAIL_h : test/robot_player_g_FAIL_h.cpp test/Robot.h test/Player.h test/globals.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o robot_player_g_FAIL_h.out test/robot_player_g_FAIL_h.cpp $(OBJS)

# output test
arena_history_player_g_h : test/arena_history_player_g_h.cpp test/Arena.h test/History.h test/Player.h test/globals.h $(OBJS)
	$(CXX) $(CPPFLAGS) -o arena_history_player_g_h.out test/arena_history_player_g_h.cpp $(OBJS)
