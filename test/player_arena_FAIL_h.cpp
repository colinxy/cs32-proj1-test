#include "Player.h"
#include "Arena.h"


int main() {
    Arena a(10, 20);
    Player p(&a, 2, 3);
    Robot r(&a, 1, 1);
}
