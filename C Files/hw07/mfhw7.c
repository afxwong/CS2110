/**
 * @file hw7.c
 * @author Austin Chemelli
 * @brief structs, pointers, pointer arithmetic, arrays, strings, and macros
 * @date 2021-10-31
 */

// DO NOT MODIFY THE INCLUDE(S) LIST
#include <stdio.h>
#include "hw7.h"
#include "my_string.h"

// Global array of pokemon structs
struct pokemon pokedex[MAX_POKEDEX_SIZE];

int size = 0;

/** catchPokemon
 *
 * @brief creates a new pokemon struct and adds it to the array of pokemon structs, "pokedex"
 *
 *
 * @param "nickname" nickname of the pokemon being created and added
 *               NOTE: if the length of the nickname (including the null terminating character)
 *               is above MAX_NICKNAME_SIZE, truncate nickname to MAX_NICKNAME_SIZE. If the length
 *               is below MIN_NICKNAME_SIZE, return FAILURE.  
 *               
 * @param "pokedexNumber" pokedexNumber of the pokemon being created and added
 * @param "powerLevel" power level of the pokemon being created and added
 * @param "speciesName" species name of the pokemon being created and added
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "nickname" is less than MIN_NICKNAME_SIZE
 *         (2) a pokemon with the same already exits in the array "pokedex"
 *         (3) adding the new pokemon would cause the size of the array "pokedex" to
 *             exceed MAX_POKEDEX_SIZE
 */
int catchPokemon(const char *nickname, int pokedexNumber, double powerLevel, const char *speciesName)
{
   /* Note about UNUSED_PARAM
   *
   * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
   * parameters prior to implementing the function. Once you begin implementing this
   * function, you can delete the UNUSED_PARAM lines.
   */

  if (size >= MAX_POKEDEX_SIZE) {
    return FAILURE;
  }
  
  struct pokemon *newPokemonPointer = &pokedex[size];

  if (my_strlen(nickname) < MIN_NICKNAME_SIZE) {
    return FAILURE;
  } else if (my_strlen(nickname) > MAX_NICKNAME_SIZE) {
    my_strncpy(newPokemonPointer->nickname, nickname, MAX_NICKNAME_SIZE - 1);
  } else {
    my_strncpy(newPokemonPointer->nickname, nickname, MAX_NICKNAME_SIZE);
  }

  if (my_strlen(speciesName) < MIN_SPECIESNAME_SIZE) {
    return FAILURE;
  } else {
    my_strncpy(newPokemonPointer->speciesName, speciesName, MAX_SPECIESNAME_SIZE);
  }

  newPokemonPointer->pokedexNumber = pokedexNumber;
  newPokemonPointer->powerLevel = powerLevel;

  int counter = 0;
  while (counter < size) {
    if (my_strncmp(pokedex[counter].nickname, newPokemonPointer->nickname, MAX_NICKNAME_SIZE) == 0) {
      return FAILURE;
    }
    counter++;
  }

  pokedex[size] = *newPokemonPointer;
  size++;
  return SUCCESS;
}

/** updatePokemonNickname
 *
 * @brief updates the nickname of an existing pokemon in the array of pokemon structs, "pokedex"
 *
 * @param "s" pokemon struct that exists in the array "pokedex"
 * @param "nickname" new nickname of pokemon "s"
 *               NOTE: if the length of nickname (including the null terminating character)
 *               is above MAX_NICKNAME_SIZE, truncate nickname to MAX_NICKNAME_SIZE
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the pokemon struct "s" can not be found in the array "pokedex"
 */
int updatePokemonNickname(struct pokemon s, const char *nickname)
{
  int counter = 0;
  while (counter < size) {
    if (my_strncmp(pokedex[counter].nickname, s.nickname, MAX_NICKNAME_SIZE) == 0) {
      if (my_strlen(nickname) > MAX_NICKNAME_SIZE) {
        my_strncpy(pokedex[counter].nickname, nickname, MAX_NICKNAME_SIZE - 1);
      } else {
        my_strncpy(pokedex[counter].nickname, nickname, MAX_NICKNAME_SIZE);
      }
      return SUCCESS;
    }
    counter++;
  }

  return FAILURE;
}

/** swapPokemon
 *
 * @brief swaps the position of two pokemon structs in the array of pokemon structs, "pokedex"
 *
 * @param "index1" index of the first pokemon struct in the array "pokedex"
 * @param "index2" index of the second pokemon struct in the array "pokedex"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "index1" and/or "index2" are negative numbers
 *         (2) "index1" and/or "index2" are out of bounds of the array "pokedex"
 */
int swapPokemon(int index1, int index2)
{
  if (index1 >= size || index2 >= size) {
    return FAILURE;
  } else if (index1 < 0 || index2 < 0) {
    return FAILURE;
  } else {
    struct pokemon tempPokemon = pokedex[index1];
    pokedex[index1] = pokedex[index2];
    pokedex[index2] = tempPokemon;
    return SUCCESS;
  }
}

/** releasePokemon
 *
 * @brief removes pokemon in the array of pokemon structs, "pokedex", that has the same nickname
 *
 * @param "s" pokemon struct that exists in the array "pokedex"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the pokemon struct "s" can not be found in the array "pokedex"
 */
int releasePokemon(struct pokemon s)
{
  int counter = 0;
  while (counter < size) {
    if (my_strncmp(pokedex[counter].nickname, s.nickname, MAX_NICKNAME_SIZE) == 0) {
      for (int i = counter; i < size; i++) {
        pokedex[i] = pokedex[i + 1];
      }
      size--;
      return SUCCESS;
    }
    counter++;
  }

  return FAILURE;
}

/** comparePokemon
 *
 * @brief compares the two pokemons' pokedex number and names (using ASCII)
 *
 * @param "s1" pokemon struct that exists in the array "pokedex"
 * @param "s2" pokemon struct that exists in the array "pokedex"
 * @return negative number if s1 is less than s2, positive number if s1 is greater
 *         than s2, and 0 if s1 is equal to s2
 */
int comparePokemon(struct pokemon s1, struct pokemon s2)
{
  if (s1.pokedexNumber > s2.pokedexNumber) {
    return 1;
  } else if (s1.pokedexNumber < s2.pokedexNumber) {
    return -1;
  } else {
    return my_strncmp(s1.nickname, s2.nickname, MAX_NICKNAME_SIZE);
  }

}

/** sortPokemon
 *
 * @brief using the comparePokemon function, sort the pokemons in the array of
 * pokemon structs, "pokedex," by the pokedex number and nicknames
 *
 * @param void
 * @return void
 */
void sortPokemon(void)
{
  for (int i = 1; i < size; i++) {
    struct pokemon tempPokemon = pokedex[i];
    int j = i - 1;
    while (j >= 0 && comparePokemon(pokedex[j], tempPokemon) > 0) {
      swapPokemon(j, j + 1);
      j--;
    }
  }
}