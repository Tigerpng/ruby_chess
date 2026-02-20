require "minitest/autorun"
require_relative "./../Board"

class TestCheckMove < Minitest::Test
  def setup
    @board = Board.new("r2qk2r/pbp2ppp/1p3nN1/b2pp3/1P1P1B2/2PBP3/P4PPP/RN1Q1RK1 b kq - 2 8")
  end

  # ============================================================
  # === GÜLTIGE BAUERNZÜGE (SCHWARZ) ==========================
  # ============================================================

  # 1 Feld nach vorne
  def test_pawn_black_valid_1_forward
    assert_equal true, @board.check_move("pe5-e4")
  end

  # 2 Felder nach vorne (Startposition)
  def test_pawn_black_valid_2_forward
    assert_equal true, @board.check_move("pc7-c5")
  end

  # Gegner vorne links schlagen
  def test_pawn_black_valid_capture_left
    assert_equal true, @board.check_move("pe5-d4")
  end

  # Gegner vorne rechts schlagen
  def test_pawn_black_valid_capture_right
    assert_equal true, @board.check_move("pe5-f4")
  end


  # ============================================================
  # === UNGÜLTIGE BAUERNZÜGE (SCHWARZ) ========================
  # ============================================================

  # 1 Feld nach hinten
  def test_pawn_black_invalid_1_backward
    assert_equal false, @board.check_move("pe5-e6")
  end

  # 2 Felder nach hinten
  def test_pawn_black_invalid_2_backward
    assert_equal false, @board.check_move("pe5-e7")
  end

  # 1 Feld nach vorne obwohl blockiert
  def test_pawn_black_invalid_blocked_1
    assert_equal false, @board.check_move("pd5-d4")
  end

  # 2 Felder nach vorne obwohl blockiert
  def test_pawn_black_invalid_blocked_2
    assert_equal false, @board.check_move("pa7-a5")
  end

  # Gegner vorne links schlagen obwohl keiner da
  def test_pawn_black_invalid_capture_left_empty
    assert_equal false, @board.check_move("pa7-b6")
  end

  # Gegner vorne rechts schlagen obwohl keiner da
  def test_pawn_black_invalid_capture_right_empty
    assert_equal false, @board.check_move("pb6-c5")
  end


  # ============================================================
  # === GÜLTIGE BAUERNZÜGE (WEISS) =============================
  # ============================================================

  # 1 Feld nach vorne
  def test_pawn_white_valid_1_forward
    assert_equal true, @board.check_move("Pb4-b5")
  end

  # 2 Felder nach vorne (Startposition)
  def test_pawn_white_valid_2_forward
    assert_equal true, @board.check_move("Pa2-a4")
  end

  # Gegner vorne links schlagen
  def test_pawn_white_valid_capture_left
    assert_equal true, @board.check_move("Pd4-c5")
  end

  # Gegner vorne rechts schlagen
  def test_pawn_white_valid_capture_right
    assert_equal true, @board.check_move("Pd4-e5")
  end


  # ============================================================
  # === UNGÜLTIGE BAUERNZÜGE (WEISS) ===========================
  # ============================================================

  # 1 Feld nach hinten
  def test_pawn_white_invalid_1_backward
    assert_equal false, @board.check_move("Pb4-b3")
  end

  # 2 Felder nach hinten
  def test_pawn_white_invalid_2_backward
    assert_equal false, @board.check_move("Pb4-b2")
  end

  # 1 Feld nach vorne obwohl blockiert
  def test_pawn_white_invalid_blocked_1
    assert_equal false, @board.check_move("Pd4-d5")
  end

  # 2 Felder nach vorne obwohl blockiert
  def test_pawn_white_invalid_blocked_2
    assert_equal false, @board.check_move("Pa2-a4")
  end

  # Gegner vorne links schlagen obwohl keiner da
  def test_pawn_white_invalid_capture_left_empty
    assert_equal false, @board.check_move("Pb4-a5")
  end

  # Gegner vorne rechts schlagen obwohl keiner da
  def test_pawn_white_invalid_capture_right_empty
    assert_equal false, @board.check_move("Pb4-c5")
  end

end